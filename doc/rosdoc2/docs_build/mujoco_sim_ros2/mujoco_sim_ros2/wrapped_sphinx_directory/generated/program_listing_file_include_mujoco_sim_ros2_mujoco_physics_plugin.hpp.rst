
.. _program_listing_file_include_mujoco_sim_ros2_mujoco_physics_plugin.hpp:

Program Listing for File mujoco_physics_plugin.hpp
==================================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_mujoco_sim_ros2_mujoco_physics_plugin.hpp>` (``include/mujoco_sim_ros2/mujoco_physics_plugin.hpp``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   /*
    * @file mujoco_physics_plugin.hpp
    * @date 1/22/25
    * @brief
    *
    * @copyright Copyright (c) 2025 Ruixiang Du (rdu)
    */
   
   #ifndef MUJOCO_PHYSICS_PLUGIN_HPP
   #define MUJOCO_PHYSICS_PLUGIN_HPP
   
   #include <rclcpp/rclcpp.hpp>
   #include "mujoco/mujoco.h"
   
   namespace mujoco_sim_ros2 {
   class MujocoPhysicsPlugin {
   public:
     virtual ~MujocoPhysicsPlugin() = default;
   
     // interface
     virtual void Configure(rclcpp::Node::SharedPtr & node,
                            rclcpp::NodeOptions cm_node_option,
                            mjModel *model, mjData *data) = 0;
     virtual void Reset(mjModel *model, mjData *data) = 0;
     virtual void PreUpdate(mjModel *model, mjData *data) {};
     virtual void Update(mjModel *model, mjData *data) {};
     virtual void PostUpdate(mjModel *model, mjData *data) {};
   
   protected:
     MujocoPhysicsPlugin() = default;
   };
   } // mujoco_ros2
   
   #endif //MUJOCO_PHYSICS_PLUGIN_HPP
