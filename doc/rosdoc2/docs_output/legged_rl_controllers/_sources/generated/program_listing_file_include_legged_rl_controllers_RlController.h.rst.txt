
.. _program_listing_file_include_legged_rl_controllers_RlController.h:

Program Listing for File RlController.h
=======================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_rl_controllers_RlController.h>` (``include/legged_rl_controllers/RlController.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 9/1/24.
   //
   
   #pragma once
   
   #include <legged_controllers/ControllerBase.h>
   
   #include <memory>
   #include <string>
   
   #include <std_msgs/msg/float64_multi_array.hpp>
   #include <realtime_tools/realtime_publisher.hpp>
   
   #include "legged_rl_controllers/Policy.h"
   #include "legged_rl_controllers/CommandManager.h"
   #include "legged_rl_controllers/ObservationManager.h"
   
   namespace legged {
   
   class RlController : public ControllerBase {
    public:
     controller_interface::CallbackReturn on_init() override;
   
     controller_interface::return_type update(const rclcpp::Time& time, const rclcpp::Duration& period) override;
   
     controller_interface::CallbackReturn on_configure(const rclcpp_lifecycle::State& previous_state) override;
   
     controller_interface::CallbackReturn on_activate(const rclcpp_lifecycle::State& previous_state) override;
   
    protected:
     virtual bool parserCommand(const std::string& name);
     virtual bool parserObservation(const std::string& name);
   
     Policy::SharedPtr policy_;
     CommandManager::SharedPtr commandManager_;
     ObservationManager::SharedPtr observationManager_;
   
     // Action
     std::string actionType_{};
     vector_t desiredPosition_;
   
     // ROS Interface
     std::shared_ptr<rclcpp::Publisher<std_msgs::msg::Float64MultiArray>> publisher_;
     std::shared_ptr<realtime_tools::RealtimePublisher<std_msgs::msg::Float64MultiArray>> publisherRealtime_;
   };
   
   }  // namespace legged
