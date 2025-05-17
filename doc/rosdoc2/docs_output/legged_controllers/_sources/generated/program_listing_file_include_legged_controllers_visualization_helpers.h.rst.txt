
.. _program_listing_file_include_legged_controllers_visualization_helpers.h:

Program Listing for File visualization_helpers.h
================================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_controllers_visualization_helpers.h>` (``include/legged_controllers/visualization_helpers.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 4/8/25.
   //
   
   #pragma once
   
   #include <legged_model/common.h>
   
   #include <vector>
   #include <std_msgs/msg/color_rgba.hpp>
   #include <geometry_msgs/msg/point.hpp>
   #include <visualization_msgs/msg/marker.hpp>
   
   namespace legged {
   enum class Color { blue, orange, yellow, purple, green, red, black };
   
   std::array<double, 3> getRGB(Color color);
   
   Color getColorFromId(size_t id);
   
   std_msgs::msg::ColorRGBA getColorMsg(Color color, float alpha = 1.0);
   
   std_msgs::msg::ColorRGBA getColorMsgFromId(size_t id, float alpha = 1.0);
   
   visualization_msgs::msg::Marker getLineMsg(std::vector<geometry_msgs::msg::Point>& points, Color color, double lineWidth);
   
   visualization_msgs::msg::Marker getEllipseMsg(const vector3_t& position, const quaternion_t& rotation, vector3_t scale, Color color);
   
   geometry_msgs::msg::Point getPointMsg(const vector3_t& point);
   
   geometry_msgs::msg::Quaternion getOrientationMsg(const quaternion_t& orientation);
   
   }  // namespace legged
