^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package legged_model
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

2.1.1 (2025-05-01)
------------------
* Merge branch 'refs/heads/master' into feature/lio_fuse
* Contributors: qiayuanl

2.1.0 (2025-04-28)
------------------
* Merge pull request `#1 <https://github.com/qiayuanl/legged_control2/issues/1>`_ from qiayuanl/fix/estimator
  Fix/estimator
* Add ZMP visualization for LinearKalmanFilterVisualization
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
* Add jointIndexMap\_ and getJointIndex at LeggedModel
* Check the contact and base name
* Add urdfdom as depend in legged_model
* Initialize q and v in constructor LeggedModel
* Replace all ZYX with quaternion
* Fix minor problem in LeggedModel
* Add LeggedModel::getJointNames
* Add LeggedModel::getFrameName
* Add IMU in LeggedModelRos2
* Add LinearKalmanFilter
* Fix initialization of pinModelPtr\_
* Use shared_library
* Using SharedPtr = std::shared_ptr
* Add legged_model_ros2
* Add legged_estimation
* Add legged_model
* Contributors: qiayuanl
