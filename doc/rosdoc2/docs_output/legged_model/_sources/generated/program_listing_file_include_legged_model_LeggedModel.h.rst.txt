
.. _program_listing_file_include_legged_model_LeggedModel.h:

Program Listing for File LeggedModel.h
======================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_model_LeggedModel.h>` (``include/legged_model/LeggedModel.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 8/29/24.
   //
   
   #pragma once
   
   #include <memory>
   #include <string>
   #include <unordered_map>
   #include <vector>
   
   #include <pinocchio/multibody/data.hpp>
   
   #include "legged_model/common.h"
   
   namespace legged {
   class LeggedModel {
    public:
     using SharedPtr = std::shared_ptr<LeggedModel>;
   
     explicit LeggedModel(const std::string& urdfXmlString);
     virtual ~LeggedModel() = default;
   
     void setEndEffectorNames(const std::vector<std::string>& threeDofContactNames, const std::vector<std::string>& sixDofContactNames);
     void setBaseNames(const std::string& baseName);
     std::string getFrameName(const size_t& frameIndex) const { return pinModelPtr_->frames[frameIndex].name; }
     std::string getBaseName() const { return getFrameName(baseFrameIndex_); }
     std::vector<std::string> getContactNames() const;
     std::vector<std::string> getJointNames() const;
   
     const pinocchio::Model& getPinModel() const { return *pinModelPtr_; }
     pinocchio::Data& getPinData() { return *pinDataPtr_; }
     const pinocchio::Data& getPinData() const { return *pinDataPtr_; }
   
     vector_t& getGeneralizedPosition() { return q_; }
     vector_t& getGeneralizedVelocity() { return v_; }
     vector_t& getTorque() { return tau_; }
   
     virtual void update();
   
     size_t getNumJoints() const { return pinModelPtr_->nv - 6; }
     size_t getNumThreeDofContacts() const { return numThreeDofContacts_; }
     size_t getNumSixDofContacts() const { return numSixDofContacts_; }
     const std::vector<size_t>& getEndEffectorFrameIndices() const { return endEffectorFrameIndices_; }
     size_t getBaseFrameIndex() const { return baseFrameIndex_; }
     size_t getJointIndex(std::string jointName) const;
   
     quaternion_t getBaseRotation() const { return quaternion_t(q_.segment<4>(3)); }
     matrix_t getMassMatrix();
     matrix_t getCoriolisMatrix();
     matrix_t getGeneralizedGravity();
     matrix_t getSelectionMatrix();
     matrix_t getContactJacobian();
     matrix_t getBaseJacobian();
   
    protected:
     std::shared_ptr<pinocchio::Model> pinModelPtr_;
     std::unique_ptr<pinocchio::Data> pinDataPtr_;
     vector_t q_, v_, tau_;
   
     size_t numThreeDofContacts_{};                 // 3DOF contacts, force only
     size_t numSixDofContacts_{};                   // 6DOF contacts, force and torque
     std::vector<size_t> endEffectorFrameIndices_;  // indices of end-effector frames [3DOF contacts, 6DOF contacts]
     size_t baseFrameIndex_{};                      // index of base frame
     std::unordered_map<std::string, size_t> jointIndexMap_;
   };
   
   std::ostream& operator<<(std::ostream& os, const LeggedModel& p);
   
   }  // namespace legged
