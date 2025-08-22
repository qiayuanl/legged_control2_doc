
.. _program_listing_file_include_legged_controllers_ControllerBase.h:

Program Listing for File ControllerBase.h
=========================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_controllers_ControllerBase.h>` (``include/legged_controllers/ControllerBase.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 9/1/24.
   //
   
   #pragma once
   
   #include <legged_model/LeggedModel.h>
   
   #include <string>
   #include <vector>
   
   #include <controller_interface/controller_interface.hpp>
   
   namespace legged {
   class ControllerBase : public controller_interface::ControllerInterface {
    public:
     const std::string interfaceName_ = "state_estimator/legged_model";
   
     [[nodiscard]] controller_interface::InterfaceConfiguration command_interface_configuration() const override;
   
     [[nodiscard]] controller_interface::InterfaceConfiguration state_interface_configuration() const override;
   
     controller_interface::return_type update(const rclcpp::Time& time, const rclcpp::Duration& period) override;
   
     controller_interface::CallbackReturn on_init() override;
   
     controller_interface::CallbackReturn on_activate(const rclcpp_lifecycle::State& previous_state) override;
   
    protected:
     void setCommands(vector_t commands, size_t offset);
     void setPositions(const vector_t& commands);
     void setVelocities(const vector_t& commands);
     void setEfforts(const vector_t& commands);
     void setStiffnesses(const vector_t& commands);
     void setDampings(const vector_t& commands);
   
     [[nodiscard]] LeggedModel::SharedPtr leggedModel() const { return *leggedModel_; }
   
     std::vector<std::string> jointNameInControl_;
     LeggedModel::SharedPtr* leggedModel_{nullptr};
   };
   
   }  // namespace legged
