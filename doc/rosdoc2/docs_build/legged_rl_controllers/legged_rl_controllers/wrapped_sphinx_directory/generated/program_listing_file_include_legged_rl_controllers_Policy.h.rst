
.. _program_listing_file_include_legged_rl_controllers_Policy.h:

Program Listing for File Policy.h
=================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_rl_controllers_Policy.h>` (``include/legged_rl_controllers/Policy.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 4/2/25.
   //
   
   #pragma once
   
   #include <legged_model/common.h>
   
   #include <memory>
   
   namespace legged {
   class Policy {
    public:
     using SharedPtr = std::shared_ptr<Policy>;
     virtual ~Policy() = default;
     virtual size_t getInputSize() const = 0;
     virtual size_t getOutputSize() const = 0;
   
     virtual void reset() = 0;
     virtual vector_t run(const vector_t& observations) = 0;
     virtual vector_t getLastOutput() const { return lastOutput_; }
   
    protected:
     vector_t lastOutput_;
   };
   
   }  // namespace legged
