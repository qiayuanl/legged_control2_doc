
.. _program_listing_file_include_legged_rl_controllers_ManagerBasedImpl.h:

Program Listing for File ManagerBasedImpl.h
===========================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_rl_controllers_ManagerBasedImpl.h>` (``include/legged_rl_controllers/ManagerBasedImpl.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 3/6/25.
   //
   
   #pragma once
   
   #include <utility>
   
   namespace legged {
   
   template <typename TermType>
   void ManagerBase<TermType>::addTerm(TermPtr term) {
     terms_.push_back(std::move(term));
     terms_.back()->setModel(model_);
   }
   
   template <typename TermType>
   vector_t ManagerBase<TermType>::getValue() {
     vector_t value(getSize());
     size_t index = 0;
     for (const auto& term : terms_) {
       const size_t size = term->getSize();
       const vector_t termValue = term->getValue();
       value.segment(index, size) = termValue;
       index += size;
     }
     return value;
   }
   
   template <typename TermType>
   typename ManagerBase<TermType>::Terms ManagerBase<TermType>::getTerms() const {
     return terms_;
   }
   
   template <typename TermType>
   size_t ManagerBase<TermType>::getSize() const {
     size_t size = 0;
     for (const auto& term : terms_) {
       size += term->getSize();
     }
     return size;
   }
   
   template <typename TermType>
   void ManagerBase<TermType>::reset() {
     for (const auto& term : terms_) {
       term->reset();
     }
   }
   
   }  // namespace legged
