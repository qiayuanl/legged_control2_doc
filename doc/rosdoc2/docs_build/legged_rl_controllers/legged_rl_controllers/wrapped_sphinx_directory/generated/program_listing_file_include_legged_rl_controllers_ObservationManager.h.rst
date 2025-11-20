
.. _program_listing_file_include_legged_rl_controllers_ObservationManager.h:

Program Listing for File ObservationManager.h
=============================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_rl_controllers_ObservationManager.h>` (``include/legged_rl_controllers/ObservationManager.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 3/5/25.
   //
   
   #pragma once
   
   #include <deque>
   #include <memory>
   #include <string>
   #include <utility>
   #include <vector>
   
   #include "legged_rl_controllers/CommandManager.h"
   #include "legged_rl_controllers/Policy.h"
   
   namespace legged {
   class ObservationTerm {
    public:
     using SharedPtr = std::shared_ptr<ObservationTerm>;
     ObservationTerm() = default;
     virtual ~ObservationTerm() = default;
     vector_t getValue() {
       const vector_t value = modify(evaluate());
       if (!initialized_) {
         history_.assign(historyLength_, value);
         initialized_ = true;
       } else {
         history_.pop_front();
         history_.push_back(value);
       }
       vector_t ret(getTotalSize());
       for (size_t i = 0; i < history_.size(); ++i) {
         ret.segment(i * getSize(), getSize()) = history_[i];
       }
       return ret;
     }
     virtual size_t getSize() const = 0;
   
     void setHistoryLength(size_t historyLength) {
       historyLength_ = historyLength;
       initialized_ = false;
       history_.clear();
     }
   
     size_t getHistoryLength() const { return historyLength_; }
     size_t getTotalSize() const { return getSize() * getHistoryLength(); }
     virtual void reset() {
       initialized_ = false;
       history_.clear();
     }
   
     virtual void setModel(const LeggedModel::SharedPtr& model) { model_ = model; }
   
    protected:
     virtual vector_t evaluate() = 0;
     virtual vector_t modify(const vector_t& observation) { return observation; }
   
     LeggedModel::SharedPtr model_{};
     size_t historyLength_{1};
   
     bool initialized_{false};
     std::deque<vector_t> history_{};
   };
   
   class ObservationManager : public ManagerBase<ObservationTerm> {
    public:
     using SharedPtr = std::shared_ptr<ObservationManager>;
     explicit ObservationManager(const LeggedModel::SharedPtr& model) : ManagerBase(model) {}
   
     void setHistoryLengths(std::vector<size_t> historyLengths) {
       for (size_t i = 0; i < terms_.size(); ++i) {
         terms_[i]->setHistoryLength(historyLengths[i]);
       }
     }
   
     vector_t getValue() override {
       vector_t value(getSize());
       size_t index = 0;
       for (size_t i = 0; i < terms_.size(); ++i) {
         size_t totalSize = terms_[i]->getTotalSize();
         value.segment(index, totalSize) = terms_[i]->getValue();
         index += totalSize;
       }
       return value;
     }
   
     size_t getSize() const override {
       size_t size = 0;
       for (size_t i = 0; i < terms_.size(); ++i) {
         size += terms_[i]->getTotalSize();
       }
       return size;
     }
   };
   
   class BaseLinVelObservationTerm final : public ObservationTerm {
    public:
     using ObservationTerm::ObservationTerm;
     size_t getSize() const override { return 3; }
   
    protected:
     vector_t evaluate() override { return model_->getGeneralizedVelocity().segment<3>(0); }
   };
   
   class BaseAngVelObservationTerm final : public ObservationTerm {
    public:
     using ObservationTerm::ObservationTerm;
     size_t getSize() const override { return 3; }
   
    protected:
     vector_t evaluate() override { return model_->getGeneralizedVelocity().segment<3>(3); }
   };
   
   class LocalObservationTerm : public ObservationTerm {
    public:
     using ObservationTerm::ObservationTerm;
     size_t getSize() const override { return 3; }
   
    protected:
     vector_t modify(const vector_t& observation) override { return model_->getBaseRotation().toRotationMatrix().transpose() * observation; }
   };
   
   class ProjectedGravityObservationTerm final : public LocalObservationTerm {
    public:
     using LocalObservationTerm::LocalObservationTerm;
   
    protected:
     vector_t evaluate() override { return vector3_t(0, 0, -1); }
   };
   
   class JointObservationTerm : public ObservationTerm {
    public:
     explicit JointObservationTerm(std::vector<std::string> jointNameInPolicy) : jointNameInPolicy_(std::move(jointNameInPolicy)) {}
     size_t getSize() const override { return jointNameInPolicy_.size(); }
   
    protected:
     vector_t modify(const vector_t& observation) override {
       vector_t modifiedObservation = observation;
       for (size_t i = 0; i < jointNameInPolicy_.size(); ++i) {
         modifiedObservation[i] = observation[model_->getJointIndex(jointNameInPolicy_[i])];
       }
       return modifiedObservation;
     }
   
     std::vector<std::string> jointNameInPolicy_;
   };
   
   class JointPositionsObservationTerm final : public JointObservationTerm {
    public:
     JointPositionsObservationTerm(const std::vector<std::string>& jointNameInPolicy, vector_t defaultPosition)
         : JointObservationTerm(jointNameInPolicy), defaultPosition_(std::move(defaultPosition)) {}
   
    protected:
     vector_t evaluate() override { return model_->getGeneralizedPosition().tail(model_->getJointNames().size()); }
     vector_t modify(const vector_t& observation) override { return JointObservationTerm::modify(observation) - defaultPosition_; }
     vector_t defaultPosition_;
   };
   
   class JointVelocitiesObservationTerm final : public JointObservationTerm {
    public:
     using JointObservationTerm::JointObservationTerm;
   
    protected:
     vector_t evaluate() override { return model_->getGeneralizedVelocity().tail(model_->getJointNames().size()); }
   };
   
   class LastActionObservationTerm final : public ObservationTerm {
    public:
     LastActionObservationTerm(Policy::SharedPtr policy) : policy_(std::move(policy)) {}
     size_t getSize() const override { return policy_->getActionSize(); }
   
    protected:
     vector_t evaluate() override { return policy_->getLastAction(); }
     Policy::SharedPtr policy_;
   };
   
   class PhaseObservationTerm final : public ObservationTerm {
    public:
     using ObservationTerm::ObservationTerm;
     PhaseObservationTerm() {}
     size_t getSize() const override { return 4; }
     void reset() override {
       phase_ = vector_t::Zero(2);
       phase_[1] = M_PI;
     }
   
    protected:
     vector_t evaluate() override {
       phase_[0] = std::fmod(phase_[0] + phaseDt_ + M_PI, 2 * M_PI) - M_PI;
       phase_[1] = std::fmod(phase_[1] + phaseDt_ + M_PI, 2 * M_PI) - M_PI;
   
       vector_t obs(4);
       vector_t phase(2);
       phase = phase_;
       obs[0] = std::cos(phase[0]);
       obs[1] = std::cos(phase[1]);
       obs[2] = std::sin(phase[0]);
       obs[3] = std::sin(phase[1]);
       return obs;
     }
   
     vector_t phase_;
     scalar_t phaseDt_{2 * M_PI * 0.02 * 1.5};
   };
   
   class CommandObservationTerm : public ObservationTerm {
    public:
     explicit CommandObservationTerm(CommandManager::SharedPtr command) : commandManager_(std::move(command)) {}
     size_t getSize() const override { return commandManager_->getSize(); }
   
    protected:
     vector_t evaluate() override { return commandManager_->getValue(); }
     CommandManager::SharedPtr commandManager_;
   };
   
   }  // namespace legged
