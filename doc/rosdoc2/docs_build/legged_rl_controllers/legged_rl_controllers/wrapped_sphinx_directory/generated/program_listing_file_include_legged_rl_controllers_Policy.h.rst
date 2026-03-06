
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
   #include <utility>
   #include <string>
   #include <vector>
   
   namespace legged {
   class Policy {
    public:
     using SharedPtr = std::shared_ptr<Policy>;
     virtual ~Policy() = default;
     virtual size_t getObservationSize() const = 0;
     virtual size_t getActionSize() const = 0;
   
     virtual void init() = 0;
     virtual void reset() = 0;
     virtual vector_t forward(const vector_t& observations) = 0;
     virtual vector_t getLastAction() = 0;
   
     std::vector<std::string> getJointNames() const { return jointNames_; }
     vector_t getJointStiffness() const { return jointStiffness_; }
     vector_t getJointDamping() const { return jointDamping_; }
     vector_t getDefaultJointPositions() const { return defaultJointPositions_; }
   
     std::vector<std::string> getCommandNames() const { return commandNames_; }
     std::vector<std::string> getObservationNames() const { return observationNames_; }
     std::vector<size_t> observationHistoryLengths() const { return observationHistoryLengths_; }
     vector_t getActionScale() const { return actionScale_; }
   
    protected:
     std::vector<std::string> jointNames_;
     vector_t jointStiffness_;
     vector_t jointDamping_;
     vector_t defaultJointPositions_;
   
     std::vector<std::string> commandNames_;
     std::vector<std::string> observationNames_;
     std::vector<size_t> observationHistoryLengths_;
     vector_t actionScale_;
   };
   
   }  // namespace legged
