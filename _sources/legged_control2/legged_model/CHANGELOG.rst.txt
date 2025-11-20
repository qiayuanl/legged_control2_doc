^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package legged_model
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

3.2.2 (2025-10-27)
------------------

3.2.1 (2025-10-21)
------------------

3.2.0 (2025-10-15)
------------------

3.1.0 (2025-10-07)
------------------

3.0.1 (2025-10-01)
------------------

3.0.0 (2025-09-16)
------------------

2.8.0 (2025-09-15)
------------------

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

2.4.0 (2025-06-14)
------------------

2.3.1 (2025-06-02)
------------------

2.3.0 (2025-05-31)
------------------

2.2.0 (2025-05-26)
------------------

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
