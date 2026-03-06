
.. _program_listing_file_include_legged_rl_controllers_CommandManager.h:

Program Listing for File CommandManager.h
=========================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_rl_controllers_CommandManager.h>` (``include/legged_rl_controllers/CommandManager.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 3/6/25.
   //
   #pragma once
   
   #include <legged_model/LeggedModel.h>
   
   #include <memory>
   #include <string>
   #include <utility>
   
   #include <geometry_msgs/msg/twist_stamped.hpp>
   #include <rclcpp_lifecycle/lifecycle_node.hpp>
   #include <realtime_tools/realtime_thread_safe_box.hpp>
   
   #include "legged_rl_controllers/ManagerBased.h"
   
   namespace legged {
   class CommandTerm {
    public:
     using SharedPtr = std::shared_ptr<CommandTerm>;
     CommandTerm() = default;
     virtual ~CommandTerm() = default;
   
     virtual vector_t getValue() = 0;
     virtual void reset() {}
     virtual size_t getSize() const = 0;
     virtual void setModel(const LeggedModel::SharedPtr& model) { model_ = model; }
   
    protected:
     LeggedModel::SharedPtr model_;
   };
   
   class CommandManager : public ManagerBase<CommandTerm> {
     using ManagerBase::ManagerBase;
   };
   
   class VelocityTopicCommandTerm : public CommandTerm {
    public:
     using Twist = geometry_msgs::msg::TwistStamped;
     VelocityTopicCommandTerm(rclcpp_lifecycle::LifecycleNode::SharedPtr node, const std::string& topicName) : node_(std::move(node)) {
       subscriber_ = node_->create_subscription<Twist>(topicName, 10, [this](const Twist::SharedPtr msg) { receivedMsg_.set(msg); });
     }
   
     vector_t getValue() override {
       std::shared_ptr<Twist> lastCommandMsg;
       receivedMsg_.get(lastCommandMsg);
       const auto timeNow = node_->get_clock()->now();
       if (lastCommandMsg->header.stamp.sec == 0 && lastCommandMsg->header.stamp.nanosec == 0) {
         RCLCPP_WARN_ONCE(node_->get_logger(),
                          "Received TwistStamped with zero timestamp, setting it to current "
                          "time, this message will only be shown once");
         lastCommandMsg->header.stamp = timeNow;
       }
       vector_t command = vector_t::Zero(3);
       if (timeNow - lastCommandMsg->header.stamp < std::chrono::milliseconds{static_cast<int>(0.5 * 1000.0)}) {
         command << lastCommandMsg->twist.linear.x, lastCommandMsg->twist.linear.y, lastCommandMsg->twist.angular.z;
       }
       return command;
     }
   
     void reset() override {
       const auto twist = std::make_shared<Twist>();
       receivedMsg_.set(twist);
     }
   
     size_t getSize() const override { return 3; }
   
    protected:
     rclcpp_lifecycle::LifecycleNode::SharedPtr node_;
     rclcpp::Subscription<Twist>::SharedPtr subscriber_;
     realtime_tools::RealtimeThreadSafeBox<std::shared_ptr<Twist>> receivedMsg_;
   };
   
   }  // namespace legged
