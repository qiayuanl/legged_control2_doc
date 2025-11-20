
.. _program_listing_file_include_mujoco_ros2_control_mujoco_system_interface.hpp:

Program Listing for File mujoco_system_interface.hpp
====================================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_mujoco_ros2_control_mujoco_system_interface.hpp>` (``include/mujoco_ros2_control/mujoco_system_interface.hpp``)

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
   
   #ifndef MUJOCO_ROS2_CONTROL__MUJOCO_SYSTEM_INTERFACE_HPP_
   #define MUJOCO_ROS2_CONTROL__MUJOCO_SYSTEM_INTERFACE_HPP_
   
   #include "hardware_interface/system_interface.hpp"
   #include "mujoco/mujoco.h"
   #include "rclcpp/rclcpp.hpp"
   #include "urdf/model.h"
   
   namespace mujoco_ros2_control
   {
   using CallbackReturn = rclcpp_lifecycle::node_interfaces::LifecycleNodeInterface::CallbackReturn;
   
   class MujocoSystemInterface : public hardware_interface::SystemInterface
   {
   public:
     virtual bool init_sim(
       rclcpp::Node::SharedPtr &node, mjModel *mujoco_model, mjData *mujoco_data,
       const urdf::Model &urdf_model, const hardware_interface::HardwareInfo &hardware_info) = 0;
   
   protected:
     rclcpp::Node::SharedPtr node_;  // TODO(sangteak601): need node?
   };
   }  // namespace mujoco_ros2_control
   
   #endif  // MUJOCO_ROS2_CONTROL__MUJOCO_SYSTEM_INTERFACE_HPP_
