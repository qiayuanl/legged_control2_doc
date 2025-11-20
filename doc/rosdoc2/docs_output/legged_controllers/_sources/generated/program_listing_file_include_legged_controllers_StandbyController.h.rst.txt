
.. _program_listing_file_include_legged_controllers_StandbyController.h:

Program Listing for File StandbyController.h
============================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_controllers_StandbyController.h>` (``include/legged_controllers/StandbyController.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 9/11/24.
   //
   
   #pragma once
   
   #include "legged_controllers/ControllerBase.h"
   
   namespace legged {
   
   class StandbyController : public ControllerBase {
    public:
     controller_interface::CallbackReturn on_init() override;
   
     controller_interface::return_type update(const rclcpp::Time& time, const rclcpp::Duration& period) override;
   
     controller_interface::CallbackReturn on_configure(const rclcpp_lifecycle::State& previous_state) override;
   
     controller_interface::CallbackReturn on_activate(const rclcpp_lifecycle::State& previous_state) override;
   
    protected:
     vector_t defaultPosition_;
     vector_t kp_, kd_;
   
     scalar_t totalTime_{2.}, maxError_{0.34};
     vector_t startPosition_;
     rclcpp::Time startTime_;
     bool firstUpdate_{true};
   };
   
   }  // namespace legged
