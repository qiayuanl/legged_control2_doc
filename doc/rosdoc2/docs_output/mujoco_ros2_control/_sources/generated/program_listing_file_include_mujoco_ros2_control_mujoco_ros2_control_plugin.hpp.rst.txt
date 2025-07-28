
.. _program_listing_file_include_mujoco_ros2_control_mujoco_ros2_control_plugin.hpp:

Program Listing for File mujoco_ros2_control_plugin.hpp
=======================================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_mujoco_ros2_control_mujoco_ros2_control_plugin.hpp>` (``include/mujoco_ros2_control/mujoco_ros2_control_plugin.hpp``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   /*
    * @file mujoco_ros2_control_plugin.hpp
    * @date 1/23/25
    * @brief
    *
    * @copyright Copyright (c) 2025 Ruixiang Du (rdu)
    */
   
   #ifndef MUJOCO_ROS2_CONTROL_PLUGIN_HPP
   #define MUJOCO_ROS2_CONTROL_PLUGIN_HPP
   
   #include <memory>
   
   #include "mujoco_ros2_control/mujoco_ros2_control.hpp"
   #include "mujoco_sim_ros2/mujoco_physics_plugin.hpp"
   
   namespace mujoco_ros2_control
   {
   class MujocoRos2ControlPlugin final : public mujoco_sim_ros2::MujocoPhysicsPlugin
   {
   public:
     MujocoRos2ControlPlugin() = default;
     virtual ~MujocoRos2ControlPlugin() = default;
   
     void Configure(
       rclcpp::Node::SharedPtr &node, rclcpp::NodeOptions cm_node_option, mjModel *model,
       mjData *data) override;
     void Reset(mjModel *model, mjData *data) override {}
     void PreUpdate(mjModel *model, mjData *data) override {}
     void Update(mjModel *model, mjData *data) override;
     void PostUpdate(mjModel *model, mjData *data) override {}
   
   private:
     std::unique_ptr<MujocoRos2Control> control_;
   };
   }  // namespace mujoco_ros2_control
   
   #endif  // MUJOCO_ROS2_CONTROL_PLUGIN_HPP
