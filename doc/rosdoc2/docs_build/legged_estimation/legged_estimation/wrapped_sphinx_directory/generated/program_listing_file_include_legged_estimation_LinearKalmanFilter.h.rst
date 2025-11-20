
.. _program_listing_file_include_legged_estimation_LinearKalmanFilter.h:

Program Listing for File LinearKalmanFilter.h
=============================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_estimation_LinearKalmanFilter.h>` (``include/legged_estimation/LinearKalmanFilter.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 8/31/24.
   //
   
   #pragma once
   
   #include <legged_model/LeggedModel.h>
   
   #include <memory>
   #include <vector>
   
   namespace legged {
   class LinearKalmanFilter {
    public:
     using SharedPtr = std::shared_ptr<LinearKalmanFilter>;
     const scalar_t highSuspectNumber_{1e-3};
   
     struct Configurations {
       scalar_t imuAccelerationNoiseDensity = 1e-2;  // 100ug/sqrt(Hz) ~ 100 * 1e-6 * 9.81 ~ 1e-3 m/s^2
       scalar_t imuAccelerationBiasNoiseDensity = 5e-3;
       scalar_t contactProcessNoisePosition = 0.002;
       scalar_t contactSensorNoisePosition = 0.002;
       scalar_t contactHeightSensorNoise = 0.002;
       scalar_t contactRadius = 0.;
       scalar_t contactForceThreshold = 150.;
       scalar_t contactForceScale = 15.;
       scalar_t contactZmpLengthX = 0.08;
       scalar_t contactZmpLengthY = 0.025;
       scalar_t positionNoiseDensity = 1e-2;
     };
   
     explicit LinearKalmanFilter(const std::shared_ptr<LeggedModel>& leggedModel);
     virtual ~LinearKalmanFilter() = default;
     void setConfigurations(const Configurations& configs) { configs_ = configs; }
     void reset();
     void updateImuProcess(scalar_t period);
     void updateContactsMeasurement(scalar_t period);
     void updatePositionMeasurement(scalar_t period, vector3_t position);
   
     void setAccelerationLocal(const vector3_t& accelerationLocal) { accelerationLocal_ = accelerationLocal; }
     void setContactWrenches(const std::vector<vector_t>& wrenches) { contactWrenches_ = wrenches; }
   
     vector3_t getPosition() const { return xHat_.head(3); }
     vector3_t getVelocityGlobal() const { return xHat_.segment(3, 3); }
     vector3_t getVelocityLocal() const { return getRotation().inverse() * getVelocityGlobal(); }
   
    protected:
     matrix3_t getRotation() const { return quaternion_t(leggedModel_->getGeneralizedPosition().segment<4>(3)).toRotationMatrix(); }
     matrix_t getKalmanGain(matrix_t c, matrix_t r) const;
     [[nodiscard]] matrix_t getImuProcessNoiseCovariance(scalar_t dt) const;
     virtual void updateContactProbabilities();
   
     LeggedModel::SharedPtr leggedModel_;
     size_t numContacts_, dimContacts_, numState_, dimContactObserve_;
     Configurations configs_;
   
     vector3_t accelerationLocal_;
     std::vector<vector_t> contactWrenches_;
   
     vector_t feetHeights_;
     vector_t contactProbabilities_;
     std::vector<vector2_t> zmps_;
   
     matrix_t a_, b_, p_, cContact_, cPosition_;
     vector_t xHat_;
   };
   
   }  // namespace legged
