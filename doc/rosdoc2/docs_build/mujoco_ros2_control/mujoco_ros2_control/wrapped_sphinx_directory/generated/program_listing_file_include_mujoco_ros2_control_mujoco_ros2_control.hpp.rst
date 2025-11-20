
.. _program_listing_file_include_mujoco_ros2_control_mujoco_ros2_control.hpp:

Program Listing for File mujoco_ros2_control.hpp
================================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_mujoco_ros2_control_mujoco_ros2_control.hpp>` (``include/mujoco_ros2_control/mujoco_ros2_control.hpp``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   // Copyright (c) 2025 Sangtaek Lee
   //
   // Permission is hereby granted, free of charge, to any person obtaining a copy
   // of this software and associated documentation files (the "Software"), to deal
   // in the Software without restriction, including without limitation the rights
   // to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   // copies of the Software, and to permit persons to whom the Software is
   // furnished to do so, subject to the following conditions:
   //
   // The above copyright notice and this permission notice shall be included in
   // all copies or substantial portions of the Software.
   //
   // THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   // IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   // FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
   // THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   // LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
   // THE SOFTWARE.
   
   #ifndef MUJOCO_ROS2_CONTROL__MUJOCO_ROS2_CONTROL_HPP_
   #define MUJOCO_ROS2_CONTROL__MUJOCO_ROS2_CONTROL_HPP_
   
   #include <memory>
   
   #include <controller_manager/controller_manager.hpp>
   #include <nav_msgs/msg/odometry.hpp>
   #include <pluginlib/class_loader.hpp>
   #include <rclcpp/rclcpp.hpp>
   #include <rosgraph_msgs/msg/clock.hpp>
   
   #include "mujoco/mujoco.h"
   
   #include "mujoco_ros2_control/mujoco_system.hpp"
   
   namespace mujoco_ros2_control
   {
   class MujocoRos2Control
   {
   public:
     MujocoRos2Control(rclcpp::Node::SharedPtr &node, mjModel *mujoco_model, mjData *mujoco_data);
     ~MujocoRos2Control();
     void init();
     void update();
   
   private:
     void publish_sim_time(rclcpp::Time sim_time);
     void publish_poses(rclcpp::Time sim_time);
   
     rclcpp::Node::SharedPtr node_;  // TODO(sangteak601): delete node
     mjModel *mj_model_;
     mjData *mj_data_;
   
     rclcpp::Logger logger_;
     std::shared_ptr<pluginlib::ClassLoader<MujocoSystemInterface>> robot_hw_sim_loader_;
   
     std::shared_ptr<controller_manager::ControllerManager> controller_manager_;
     rclcpp::executors::MultiThreadedExecutor::SharedPtr cm_executor_;
     std::thread cm_thread_;
     bool stop_cm_thread_;
     rclcpp::Duration control_period_;
   
     rclcpp::Time last_update_sim_time_ros_;
     rclcpp::Publisher<rosgraph_msgs::msg::Clock>::SharedPtr clock_publisher_;
     std::map<std::string, rclcpp::Publisher<nav_msgs::msg::Odometry>::SharedPtr> odom_publishers_;
     std::map<std::string, nav_msgs::msg::Odometry> odom_msgs_;
   };
   }  // namespace mujoco_ros2_control
   
   #endif  // MUJOCO_ROS2_CONTROL__MUJOCO_ROS2_CONTROL_HPP_
