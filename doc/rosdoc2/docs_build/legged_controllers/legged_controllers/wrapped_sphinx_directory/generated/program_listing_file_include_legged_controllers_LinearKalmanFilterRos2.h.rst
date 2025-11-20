
.. _program_listing_file_include_legged_controllers_LinearKalmanFilterRos2.h:

Program Listing for File LinearKalmanFilterRos2.h
=================================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_controllers_LinearKalmanFilterRos2.h>` (``include/legged_controllers/LinearKalmanFilterRos2.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 8/31/24.
   //
   
   #pragma once
   
   #include <legged_estimation/LinearKalmanFilter.h>
   
   #include <memory>
   #include <string>
   #include <vector>
   
   #include <nav_msgs/msg/odometry.hpp>
   #include <rclcpp_lifecycle/lifecycle_node.hpp>
   #include <realtime_tools/realtime_publisher.hpp>
   #include <tf2_msgs/msg/tf_message.hpp>
   #include <visualization_msgs/msg/marker_array.hpp>
   
   #include "legged_controllers/visualization_helpers.h"
   
   namespace legged {
   
   class LinearKalmanFilterVisualization {
    public:
     std::string frameId_ = "odom";
     scalar_t alpha_ = 0.2;
     scalar_t zmpScale_ = 0.02;
   
     using SharedPtr = std::shared_ptr<LinearKalmanFilterVisualization>;
     LinearKalmanFilterVisualization(const LeggedModel::SharedPtr& leggedModel, const rclcpp_lifecycle::LifecycleNode::SharedPtr& node);
     virtual ~LinearKalmanFilterVisualization() = default;
     virtual void update(const rclcpp::Time& time, const rclcpp::Duration& period, const vector_t& xHat, const matrix_t& p,
                         const std::vector<vector2_t>& zmps);
   
    protected:
     LeggedModel::SharedPtr leggedModel_;
     rclcpp::Publisher<visualization_msgs::msg::MarkerArray>::SharedPtr publisher_;
   };
   
   class LinearKalmanFilterRos2 : public LinearKalmanFilter {
    public:
     using SharedPtr = std::shared_ptr<LinearKalmanFilterRos2>;
   
     LinearKalmanFilterRos2(const rclcpp_lifecycle::LifecycleNode::SharedPtr& node, const LeggedModel::SharedPtr& leggedModel);
     virtual void update(const rclcpp::Time& time, const rclcpp::Duration& period);
     virtual void sendRos(const rclcpp::Time& time, const rclcpp::Duration& period);
   
    protected:
     std::shared_ptr<rclcpp::Publisher<nav_msgs::msg::Odometry>> odomPublisher_;
     std::shared_ptr<realtime_tools::RealtimePublisher<nav_msgs::msg::Odometry>> odomPublisherRealtime_;
   
     LinearKalmanFilterVisualization::SharedPtr visualization_;
   };
   
   }  // namespace legged
