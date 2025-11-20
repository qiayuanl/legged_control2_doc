
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
   
   #include <iostream>
   #include <map>
   #include <memory>
   #include <string>
   #include <vector>
   #include <utility>
   #include <type_traits>
   
   #include "legged_rl_controllers/Policy.h"
   
   namespace legged {
   
   template <typename T>
   std::vector<T> parseCsv(const std::string& s, char delim = ',') {
     std::vector<T> out;
     std::stringstream ss(s);
     std::string item;
   
     while (std::getline(ss, item, delim)) {
       if constexpr (std::is_same_v<T, double>)  // numeric branch
       {
         out.emplace_back(std::stod(item));
       } else if constexpr (std::is_same_v<T, size_t>) {
         out.emplace_back(std::stoul(item));
       } else {
         out.emplace_back(item);
       }
     }
     return out;
   }
   
   template <typename T>
   std::ostream& operator<<(std::ostream& os, const std::vector<T>& vec) {
     os << '[';
     for (std::size_t i = 0; i < vec.size(); ++i) {
       if (i) os << ", ";
       os << vec[i];
     }
     return os << ']';
   }
   
   class OnnxPolicy : public Policy {
    public:
     using SharedPtr = std::shared_ptr<OnnxPolicy>;
     using tensor_element_t = float;
     using tensor2d_t = Eigen::Matrix<tensor_element_t, Eigen::Dynamic, Eigen::Dynamic, Eigen::RowMajor>;
   
     explicit OnnxPolicy(const std::string& modelPath);
     size_t getObservationSize() const override { return inputShapes_[name2Index_.at("obs")][1]; }
     size_t getActionSize() const override { return outputShapes_[name2Index_.at("actions")][1]; }
   
     void init() override;
     void reset() override { outputTensors_[name2Index_.at("actions")] = tensor2d_t::Zero(1, getActionSize()); }
     vector_t getLastAction() override { return outputTensors_[name2Index_.at("actions")].row(0).cast<double>(); }
     vector_t forward(const vector_t& observations) override;
   
    protected:
     std::string getMetadataStr(const std::string& key) const {
       auto it = name2Metadata_.find(std::string(key));
       if (it == name2Metadata_.end()) {
         throw std::runtime_error("OnnxPolicy: '" + std::string(key) + "' not found in model metadata. Please check the model.");
       }
       return it->second;
     }
     vector_t getMetadataVector(const std::string& key, bool verbose = true) const {
       const auto tmp = parseCsv<scalar_t>(getMetadataStr(key));
       vector_t target = Eigen::Map<const vector_t>(tmp.data(), tmp.size());
       if (verbose) std::cout << '\t' << key << ": " << target.transpose() << '\n';
       return target;
     }
     virtual void parseMetadata();
     virtual void parseInputOutput();
     virtual void checkInputOutput();
     void run();
   
     std::shared_ptr<Ort::Env> onnxEnvPrt_;
     std::unique_ptr<Ort::Session> sessionPtr_;
     std::map<std::string, std::string> name2Metadata_;
   
     std::vector<Ort::AllocatedStringPtr> inputNamesRaw_;
     std::vector<Ort::AllocatedStringPtr> outputNamesRaw_;
     std::vector<const char*> inputNames_;
     std::vector<const char*> outputNames_;
     std::vector<std::vector<int64_t>> inputShapes_;
     std::vector<std::vector<int64_t>> outputShapes_;
     std::map<std::string, size_t> name2Index_;
   
     std::vector<tensor2d_t> inputTensors_;
     std::vector<tensor2d_t> outputTensors_;
   };
   
   }  // namespace legged
