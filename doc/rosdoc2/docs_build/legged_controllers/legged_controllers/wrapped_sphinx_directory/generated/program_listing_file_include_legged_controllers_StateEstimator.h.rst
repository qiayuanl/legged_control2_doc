
.. _program_listing_file_include_legged_controllers_StateEstimator.h:

Program Listing for File StateEstimator.h
=========================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_controllers_StateEstimator.h>` (``include/legged_controllers/StateEstimator.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 8/30/24.
   //
   
   #pragma once
   
   #include <memory>
   #include <string>
   #include <vector>
   
   #include <controller_interface/chainable_controller_interface.hpp>
   #include <semantic_components/imu_sensor.hpp>
   #include <realtime_tools/realtime_thread_safe_box.hpp>
   #include <nav_msgs/msg/odometry.hpp>
   #include <sensor_msgs/msg/joint_state.hpp>
   
   #include "legged_controllers/GmObserverRos2.h"
   #include "legged_controllers/LinearKalmanFilterRos2.h"
   #include "legged_controllers/JointSensors.h"
   
   namespace legged {
   class StateEstimator : public controller_interface::ChainableControllerInterface {
    public:
     using Odom = nav_msgs::msg::Odometry;
     const std::string tfTopic_ = "/tf";
     const std::string jointTopic_ = "/joint_states";
   
     [[nodiscard]] controller_interface::InterfaceConfiguration command_interface_configuration() const override;
   
     [[nodiscard]] controller_interface::InterfaceConfiguration state_interface_configuration() const override;
   
     controller_interface::return_type update_and_write_commands(const rclcpp::Time& time, const rclcpp::Duration& period) override;
   
     controller_interface::CallbackReturn on_init() override;
   
     controller_interface::CallbackReturn on_configure(const rclcpp_lifecycle::State& previous_state) override;
   
     controller_interface::CallbackReturn on_activate(const rclcpp_lifecycle::State& previous_state) override;
   
     controller_interface::CallbackReturn on_deactivate(const rclcpp_lifecycle::State& previous_state) override;
   
     std::vector<hardware_interface::StateInterface> on_export_state_interfaces() override;
   
     controller_interface::return_type update_reference_from_subscribers(const rclcpp::Time& time, const rclcpp::Duration& period) override {
       return controller_interface::return_type::OK;
     };
   
    protected:
     LeggedModel::SharedPtr leggedModel_;
     LeggedModel::SharedPtr* leggedModelPtr_ = &leggedModel_;
   
     std::shared_ptr<semantic_components::JointSensors> joints_;
     std::shared_ptr<semantic_components::IMUSensor> imu_;
   
     GmObserverRos2::SharedPtr gmObserver_;
     LinearKalmanFilterRos2::SharedPtr linearKalmanFilter_;
   
     std::shared_ptr<rclcpp::Subscription<Odom>> poseSubscriber_;
     realtime_tools::RealtimeThreadSafeBox<Odom> poseStamped_;
     Odom poseStampedLast_;
     size_t topicFrameIndex_ = 0;
     quaternion_t worldToMap_ = quaternion_t::Identity();
   
     std::shared_ptr<rclcpp::Publisher<tf2_msgs::msg::TFMessage>> odomTfPublisher_;
     std::shared_ptr<realtime_tools::RealtimePublisher<tf2_msgs::msg::TFMessage>> odomTfPublisherRealtime_;
   
     std::shared_ptr<rclcpp::Publisher<sensor_msgs::msg::JointState>> jointStatesPublisher_;
     std::shared_ptr<realtime_tools::RealtimePublisher<sensor_msgs::msg::JointState>> jointStatesPublisherRealtime_;
   };
   
   template <typename Scalar>
   Eigen::Quaternion<Scalar> yawQuaternion(const Eigen::Quaternion<Scalar>& q) {
     Scalar yaw = std::atan2(Scalar(2) * (q.w() * q.z() + q.x() * q.y()), Scalar(1) - Scalar(2) * (q.y() * q.y() + q.z() * q.z()));
     Scalar half_yaw = yaw * Scalar(0.5);
     Eigen::Quaternion<Scalar> ret(std::cos(half_yaw), Scalar(0), Scalar(0), std::sin(half_yaw));
     return ret.normalized();
   }
   
   }  // namespace legged
