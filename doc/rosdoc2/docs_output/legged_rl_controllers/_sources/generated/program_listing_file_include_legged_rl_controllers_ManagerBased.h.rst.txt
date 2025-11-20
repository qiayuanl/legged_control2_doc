
.. _program_listing_file_include_legged_rl_controllers_ManagerBased.h:

Program Listing for File ManagerBased.h
=======================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_rl_controllers_ManagerBased.h>` (``include/legged_rl_controllers/ManagerBased.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 3/6/25.
   //
   
   #pragma once
   
   #include <legged_model/common.h>
   
   #include <memory>
   #include <vector>
   #include <utility>
   
   namespace legged {
   
   template <typename TermType>
   class ManagerBase {
    public:
     using TermPtr = typename TermType::SharedPtr;
     using Terms = std::vector<TermPtr>;
     using SharedPtr = std::shared_ptr<ManagerBase>;
   
     explicit ManagerBase(LeggedModel::SharedPtr model) : model_(std::move(model)) {}
     virtual ~ManagerBase() = default;
   
     void addTerm(TermPtr term);
     Terms getTerms() const;
     virtual vector_t getValue();
     virtual size_t getSize() const;
     virtual void reset();
   
    protected:
     LeggedModel::SharedPtr model_;
     Terms terms_;
   };
   
   }  // namespace legged
   
   #include "legged_rl_controllers/ManagerBasedImpl.h"
