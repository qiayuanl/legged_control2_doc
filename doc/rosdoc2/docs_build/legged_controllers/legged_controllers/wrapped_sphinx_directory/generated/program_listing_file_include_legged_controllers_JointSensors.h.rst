
.. _program_listing_file_include_legged_controllers_JointSensors.h:

Program Listing for File JointSensors.h
=======================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_controllers_JointSensors.h>` (``include/legged_controllers/JointSensors.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 4/20/25.
   //
   
   #pragma once
   
   #include <legged_model/common.h>
   
   #include <memory>
   
   #include <hardware_interface/types/hardware_interface_type_values.hpp>
   #include <semantic_components/semantic_component_interface.hpp>
   
   namespace semantic_components {
   using legged::vector_t;
   
   class JointSensors : public SemanticComponentInterface<double> {
    public:
     using SharedPtr = std::shared_ptr<JointSensors>;
     explicit JointSensors(const pinocchio::Model& model) : SemanticComponentInterface("", 0), numJoints_(model.njoints - 2), model_(model) {
       for (size_t k = 2; k < model.njoints; ++k) {
         interface_names_.emplace_back(model.names[k] + "/" + hardware_interface::HW_IF_POSITION);
         interface_names_.emplace_back(model.names[k] + "/" + hardware_interface::HW_IF_VELOCITY);
         interface_names_.emplace_back(model.names[k] + "/" + hardware_interface::HW_IF_EFFORT);
       }
     }
     vector_t getPositions() const {
       vector_t q = vector_t::Zero(numJoints_);
       for (size_t j = 0; j < numJoints_; ++j) {
         q(j) = state_interfaces_[3 * j].get().get_value();
       }
       return q;
     }
     vector_t getVelocities() const {
       vector_t v = vector_t::Zero(numJoints_);
       for (size_t j = 0; j < numJoints_; ++j) {
         v(j) = state_interfaces_[3 * j + 1].get().get_value();
       }
       return v;
     }
     vector_t getTorques() const {
       vector_t tau = vector_t::Zero(numJoints_);
       for (size_t j = 0; j < numJoints_; ++j) {
         tau(j) = state_interfaces_[3 * j + 2].get().get_value();
       }
       return tau;
     }
   
    protected:
     size_t numJoints_;
     pinocchio::Model model_;
   };
   
   }  // namespace semantic_components
