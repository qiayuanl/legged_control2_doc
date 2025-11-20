
.. _program_listing_file_include_legged_rl_controllers_OnnxController.h:

Program Listing for File OnnxController.h
=========================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_rl_controllers_OnnxController.h>` (``include/legged_rl_controllers/OnnxController.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 4/2/25.
   //
   
   #pragma once
   
   #include "legged_rl_controllers/RlController.h"
   
   namespace legged {
   class OnnxController : public RlController {
    public:
     controller_interface::CallbackReturn on_configure(const rclcpp_lifecycle::State& previous_state) override;
   };
   
   }  // namespace legged
