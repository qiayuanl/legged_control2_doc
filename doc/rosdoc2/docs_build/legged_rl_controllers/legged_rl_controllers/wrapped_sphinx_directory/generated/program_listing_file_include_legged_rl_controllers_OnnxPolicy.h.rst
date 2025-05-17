
.. _program_listing_file_include_legged_rl_controllers_OnnxPolicy.h:

Program Listing for File OnnxPolicy.h
=====================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_rl_controllers_OnnxPolicy.h>` (``include/legged_rl_controllers/OnnxPolicy.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 3/6/25.
   //
   #pragma once
   
   #include <onnxruntime/onnxruntime_cxx_api.h>
   
   #include <memory>
   #include <string>
   #include <vector>
   
   #include "legged_rl_controllers/Policy.h"
   
   namespace legged {
   
   class OnnxPolicy : public Policy {
    public:
     using SharedPtr = std::shared_ptr<OnnxPolicy>;
     using tensor_element_t = float;
     explicit OnnxPolicy(const std::string& modelPath);
     size_t getInputSize() const override { return inputShapes_[0][1]; }
     size_t getOutputSize() const override { return outputShapes_[0][1]; }
   
     void reset() override { lastOutput_ = vector_t::Zero(getOutputSize()); }
     vector_t run(const vector_t& observations) override;
   
    protected:
     std::shared_ptr<Ort::Env> onnxEnvPrt_;
     std::unique_ptr<Ort::Session> sessionPtr_;
     std::vector<const char*> inputNames_;
     std::vector<const char*> outputNames_;
     std::vector<std::vector<int64_t>> inputShapes_;
     std::vector<std::vector<int64_t>> outputShapes_;
   };
   
   }  // namespace legged
