
.. _program_listing_file_include_legged_controllers_GmObserverRos2.h:

Program Listing for File GmObserverRos2.h
=========================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_controllers_GmObserverRos2.h>` (``include/legged_controllers/GmObserverRos2.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 8/31/24.
   //
   
   #pragma once
   
   #include <legged_estimation/GmObserver.h>
   
   #include <memory>
   #include <vector>
   
   #include <geometry_msgs/msg/wrench_stamped.hpp>
   #include <rclcpp_lifecycle/lifecycle_node.hpp>
   #include <realtime_tools/realtime_publisher.hpp>
   
   namespace legged {
   class GmObserverRos2 : public GmObserver {
    public:
     using SharedPtr = std::shared_ptr<GmObserverRos2>;
     GmObserverRos2(const std::shared_ptr<rclcpp_lifecycle::LifecycleNode>& node, const std::shared_ptr<LeggedModel>& leggedModel,
                    scalar_t cutoffFrequency = 10);
   
     void update(const rclcpp::Time& time, const rclcpp::Duration& period);
   
    protected:
     std::vector<std::shared_ptr<rclcpp::Publisher<geometry_msgs::msg::WrenchStamped>>> wrenchesPub_;
     std::vector<std::shared_ptr<realtime_tools::RealtimePublisher<geometry_msgs::msg::WrenchStamped>>> wrenchesPubRealtime_;
   };
   
   }  // namespace legged
