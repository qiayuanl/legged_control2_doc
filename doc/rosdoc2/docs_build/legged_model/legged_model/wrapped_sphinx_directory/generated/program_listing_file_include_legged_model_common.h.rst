
.. _program_listing_file_include_legged_model_common.h:

Program Listing for File common.h
=================================

|exhale_lsh| :ref:`Return to documentation for file <file_include_legged_model_common.h>` (``include/legged_model/common.h``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

   //
   // Created by qiayuanl on 8/29/24.
   //
   
   #pragma once
   
   #include <Eigen/Core>
   #include <Eigen/Geometry>
   
   namespace legged {
   using scalar_t = double;
   using vector_t = Eigen::VectorXd;
   using matrix_t = Eigen::MatrixXd;
   using vector2_t = Eigen::Matrix<scalar_t, 2, 1>;
   using vector3_t = Eigen::Matrix<scalar_t, 3, 1>;
   using matrix3_t = Eigen::Matrix<scalar_t, 3, 3>;
   using quaternion_t = Eigen::Quaterniond;
   
   }  // namespace legged
