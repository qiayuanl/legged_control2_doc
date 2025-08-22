
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
   #include <vector>
   #include <algorithm>
   
   #include <std_msgs/msg/float64_multi_array.hpp>
   #include <realtime_tools/realtime_publisher.hpp>
   
   #include "legged_rl_controllers/Policy.h"
   #include "legged_rl_controllers/CommandManager.h"
   #include "legged_rl_controllers/ObservationManager.h"
   
   namespace legged {
   
   class RepeatedTimer {
    public:
     RepeatedTimer()
         : numTimedIntervals_(0),
           totalTime_(std::chrono::nanoseconds::zero()),
           maxIntervalTime_(std::chrono::nanoseconds::zero()),
           lastIntervalTime_(std::chrono::nanoseconds::zero()),
           startTime_(std::chrono::steady_clock::now()) {}
   
     void reset() {
       numTimedIntervals_ = 0;
       totalTime_ = std::chrono::nanoseconds::zero();
       maxIntervalTime_ = std::chrono::nanoseconds::zero();
       lastIntervalTime_ = std::chrono::nanoseconds::zero();
     }
   
     void startTimer() { startTime_ = std::chrono::steady_clock::now(); }
   
     void endTimer() {
       auto endTime = std::chrono::steady_clock::now();
       lastIntervalTime_ = std::chrono::duration_cast<std::chrono::nanoseconds>(endTime - startTime_);
       maxIntervalTime_ = std::max(maxIntervalTime_, lastIntervalTime_);
       totalTime_ += lastIntervalTime_;
       numTimedIntervals_++;
     }
   
     int getNumTimedIntervals() const { return numTimedIntervals_; }
   
     scalar_t getTotalInMilliseconds() const { return std::chrono::duration<scalar_t, std::milli>(totalTime_).count(); }
   
     scalar_t getMaxIntervalInMilliseconds() const { return std::chrono::duration<scalar_t, std::milli>(maxIntervalTime_).count(); }
   
     scalar_t getLastIntervalInMilliseconds() const { return std::chrono::duration<scalar_t, std::milli>(lastIntervalTime_).count(); }
   
     scalar_t getAverageInMilliseconds() const { return getTotalInMilliseconds() / numTimedIntervals_; }
   
    private:
     int numTimedIntervals_;
     std::chrono::nanoseconds totalTime_;
     std::chrono::nanoseconds maxIntervalTime_;
     std::chrono::nanoseconds lastIntervalTime_;
     std::chrono::steady_clock::time_point startTime_;
   };
   
   class RlController : public ControllerBase {
    public:
     controller_interface::return_type update(const rclcpp::Time& time, const rclcpp::Duration& period) override;
   
     controller_interface::CallbackReturn on_configure(const rclcpp_lifecycle::State& previous_state) override;
   
     controller_interface::CallbackReturn on_activate(const rclcpp_lifecycle::State& previous_state) override;
   
     controller_interface::CallbackReturn on_deactivate(const rclcpp_lifecycle::State& previous_state) override;
   
    protected:
     void runPolicy();
   
     virtual bool parserCommand(const std::string& name);
     virtual bool parserObservation(const std::string& name);
   
     Policy::SharedPtr policy_;
     CommandManager::SharedPtr commandManager_;
     ObservationManager::SharedPtr observationManager_;
   
     bool async_{false};
     std::atomic_bool running_{false};
     std::thread policyThread_;
     RepeatedTimer policyTimer_;
     // Action
     std::string actionType_{"position_absolute"};
     vector_t desiredPosition_;
   
     // Time
     scalar_t policyFrequency_{50.};
     rclcpp::Time lastPlayTime_;
   
     // Config
     int historySize_{1};
     bool historyByTerm_{true};
   
     // ROS Interface
     std::shared_ptr<rclcpp::Publisher<std_msgs::msg::Float64MultiArray>> publisher_;
     std::shared_ptr<realtime_tools::RealtimePublisher<std_msgs::msg::Float64MultiArray>> publisherRealtime_;
   };
   
   template <typename Functor1, typename Functor2>
   void executeAtRate(Functor1 f, Functor2 condition, double frequency) {
     using clock = std::chrono::high_resolution_clock;
   
     // Compute desired duration rounded to clock decimation
     const std::chrono::duration<double> desiredDuration(1.0 / frequency);
     const auto dt = std::chrono::duration_cast<clock::duration>(desiredDuration);
   
     // Initialize timing
     const auto start = clock::now();
     auto sleepTill = start + dt;
   
     // Execution loop
     while (condition()) {
       // Execute wrapped function
       f();
   
       // Sleep
       std::this_thread::sleep_until(sleepTill);
       sleepTill += dt;
     }
   }
   
   }  // namespace legged
