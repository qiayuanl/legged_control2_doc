^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package legged_controllers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

3.2.2 (2025-10-27)
------------------
* Add estimation position topic and frame_id declarations
* Contributors: qiayuanl

3.2.1 (2025-10-21)
------------------

3.2.0 (2025-10-15)
------------------
* Use StateInterface for state_estimator/legged_model output
* Contributors: qiayuanl

3.1.0 (2025-10-07)
------------------

3.0.1 (2025-10-01)
------------------
* Handle simulation reset in StateEstimator by skipping non-positive period
* Contributors: qiayuanl

3.0.0 (2025-09-16)
------------------
* Refactor parameter retrieval of LinearKalmanFilterRos2 and GmObserverRos2 to use declare_parameter
* Upgrade to jazzy: change the interface and remove custom update_rate/async support
* Contributors: qiayuanl

2.8.0 (2025-09-15)
------------------
* Add on_init method to StandbyController and StateEstimator for parameter declaration
* Handle zero duration in update_and_write_commands to prevent division by zero
* Contributors: qiayuanl

2.7.3 (2025-07-27)
------------------

2.7.2 (2025-07-21)
------------------
* Update CHANGELOG.rst
* Contributors: qiayuanl

* Update CHANGELOG.rst
* Contributors: qiayuanl

2.7.1 (2025-07-11)
------------------

2.7.0 (2025-06-17)
------------------
* Merge branch 'master' into feature/async
  # Conflicts:
  #	legged_rl_controllers/src/RlController.cpp
* Merge branch 'master' into feature/async
* Merge branch 'master' into feature/async
* Contributors: qiayuanl

2.6.0 (2025-06-17)
------------------

2.5.0 (2025-06-15)
------------------
* Merge pull request `#7 <https://github.com/qiayuanl/legged_control2/issues/7>`_ from qiayuanl/feature/onnx_metadata
  Read metadata from onnx files instead of ros parameters
* Read metadata from onnx files instead of ros parameters
* Contributors: Qiayuan Liao, qiayuanl

2.4.0 (2025-06-14)
------------------

2.3.1 (2025-06-02)
------------------
* Merge pull request `#5 <https://github.com/qiayuanl/legged_control2/issues/5>`_ from qiayuanl/fix/estimation_position_default
  Fix the behavior when estimation.position.topic and estimation.positi…
* Fix the behavior when estimation.position.topic and estimation.position.frame_id is empty
* Contributors: Qiayuan Liao, qiayuanl

2.3.0 (2025-05-31)
------------------

2.2.0 (2025-05-26)
------------------
* Merge pull request `#4 <https://github.com/qiayuanl/legged_control2/issues/4>`_ from qiayuanl/feature/joint_state
  Remove joint_state_broadcaster
* Remove joint_state_broadcaster
* Contributors: Qiayuan Liao, qiayuanl

2.1.1 (2025-05-01)
------------------
* Merge pull request `#3 <https://github.com/qiayuanl/legged_control2/issues/3>`_ from qiayuanl/feature/lio_fuse
  Feature/lio fuse
* Merge branch 'refs/heads/master' into feature/lio_fuse
* Force worldToMap\_ to be only rotated along z axis in StateEstimator
* Contributors: Qiayuan Liao, qiayuanl

2.1.0 (2025-04-28)
------------------
* Merge pull request `#2 <https://github.com/qiayuanl/legged_control2/issues/2>`_ from qiayuanl/feature/lio_fuse
  Feature/lio fuse
* Merge pull request `#1 <https://github.com/qiayuanl/legged_control2/issues/1>`_ from qiayuanl/fix/estimator
  Fix/estimator
* Move TF publication to StateEstimation and add odom_lio frame
* Add low pass filter for world-to-map in StateEstimator
* Map LIO information in world frame instead of overwriting everything to map frame
* Move the position sensor topic from LinearKalmanFilterRos2 to StateEstimator.
* Support position sensor from any frame on the robot
* Remove MoCap and call updatePositionMeasurement() in LinearKalmanFilterRos2
* Separate LinearKalmanFilter::update() to LinearKalmanFilter::updateImuProcess() and LinearKalmanFilter::updateContactsMeasurement()
* Separate chainable controllers from legged_controllers
* Correct joint order of StandbyController
* Adjust the RlController for new ControllerBase
* Change StateEstimator to ChainableController, so that all other controllers share the same state estimator. legged_controllers work, but legged_rl_controller still not.
* Add configuration for contact probabilities of LinearKalmanFilter
* Add acceleration bias estimation
* Override the xHat correctly in MoCap
* Add ZMP visualization for LinearKalmanFilterVisualization
* Add LinearKalmanFilter::updateContactProbabilities, use force threshold and ZMP to determine the probability
* Correct LinearKalmanFilterVisualization
* Add LinearKalmanFilter::reset
* Add LinearKalmanFilter::getImuProcessNoiseCovariance
* Remove foot velocity measurement from  LinearKalmanFilter
* Add visualization for LinearKalmanFilterRos2
* Add visualization_helpers
* Contributors: Qiayuan Liao, qiayuanl

2.0.0 (2025-04-08)
------------------

1.4.0 (2025-04-02)
------------------

1.3.1 (2025-04-01)
------------------

1.3.0 (2025-03-29)
------------------

1.2.1 (2025-03-29)
------------------
* Add and run pre-commit
* Contributors: qiayuanl

1.2.0 (2025-03-28)
------------------

1.1.0 (2025-03-26)
------------------
* Update Mocap code
* Add gm_observer.cut_off_frequency and gm_observer.force_threshold configuration
* Update OnnxController with Manger
* Minor change for formate
* Remove the client for getting robot_description
* Correct phase cycle
* Add phase observation
* Move exec_depend from unitree_description to legged_controllers
* Use new hardware interface
* Get robot_description from robot_state_publisher
* Add TopicController
* Add default_position and kp, kd parameters interface
* Add StandbyController
* Fix some minor problems
* Call StateEstimator::on_deactivate at the beginning of ControllerBase::on_deactivate
* Fix a minor problem in Mocap
* Add Mocap
* Add param interface for LinearKalmanFilter
* Add param interface for LeggedModelRos2
* Add ControllerBase::on_deactivate
* Replace all ZYX with quaternion
* Fix a silly bug cause by copilot
* Fix minor problem in LeggedModel
* Add legged_rl_controllers
* Set frame names in StateEstimator manually
* Correct some return value in ControllerBase
* Add ControllerBase
* Add baseFrameIndex to contactIndices in GmObserverRos2
* Add unlock after setup message in realtime publisher
* Correct "Remove imu inside LeggedModelRos2"
* Remove imu inside LeggedModelRos2
* Add LinearKalmanFilterRos2
* Add LeggedModel::getFrameName
* Add GmObserverRos2
* Add GmObserverRos2
* Minor change
* Add legged_controllers
* Contributors: qiayuanl
