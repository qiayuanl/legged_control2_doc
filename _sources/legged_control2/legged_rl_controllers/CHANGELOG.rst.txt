^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package legged_rl_controllers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

3.2.2 (2025-10-27)
------------------

3.2.1 (2025-10-21)
------------------
* Refactor ObservationTerm to fill the entire history with the first evaluated value instead of zeros.
  (cherry picked from commit 646b44a0622cac686725d4f076656f81630537d3)
* Contributors: qiayuanl

3.2.0 (2025-10-15)
------------------

3.1.0 (2025-10-07)
------------------
* Refactor ObservationManager to manage history length and improve value retrieval
  (cherry picked from commit b19fddc7077be351bd6e7d3eb49df678b775b44b)
* Contributors: qiayuanl

3.0.1 (2025-10-01)
------------------

3.0.0 (2025-09-16)
------------------
* Upgrade to jazzy: change the interface and remove custom update_rate/async support
* Implement on_init method and update parameter handling in RlController
* Contributors: qiayuanl

2.8.0 (2025-09-15)
------------------

2.7.3 (2025-07-27)
------------------

2.7.2 (2025-07-21)
------------------
* Update CHANGELOG.rst
* Refactor action scale handling to support vector_t type
* Contributors: qiayuanl

* Update CHANGELOG.rst
* Refactor action scale handling to support vector_t type
* Contributors: qiayuanl

* Refactor action scale handling to support vector_t type
* Contributors: qiayuanl

2.7.1 (2025-07-11)
------------------
* Add verbose for getMetadataVector
* Contributors: qiayuanl

2.7.0 (2025-06-17)
------------------
* Merge pull request `#8 <https://github.com/qiayuanl/legged_control2/issues/8>`_ from qiayuanl/feature/async
  Feature/async
* Merge branch 'master' into feature/async
  # Conflicts:
  #	legged_rl_controllers/src/RlController.cpp
* Merge branch 'master' into feature/async
* Merge branch 'master' into feature/async
* Add async parameter
* Add parallel policy inference
* Contributors: Qiayuan Liao, qiayuanl

2.6.0 (2025-06-17)
------------------
* Add Policy::init()
* Add more printing for the metadata of OnnxPolicy
* Contributors: qiayuanl

2.5.0 (2025-06-15)
------------------
* Merge pull request `#7 <https://github.com/qiayuanl/legged_control2/issues/7>`_ from qiayuanl/feature/onnx_metadata
  Read metadata from onnx files instead of ros parameters
* Read metadata from onnx files instead of ros parameters
* Contributors: Qiayuan Liao, qiayuanl

2.4.0 (2025-06-14)
------------------
* Merge pull request `#6 <https://github.com/qiayuanl/legged_control2/issues/6>`_ from qiayuanl/feature/mimo_onnx
  Refactor Policy and OnnxPolicy to support multi-input multi-output
* Refactor Policy and OnnxPolicy to support multi-input multi-output
* Contributors: Qiayuan Liao, qiayuanl

2.3.1 (2025-06-02)
------------------

2.3.0 (2025-05-31)
------------------
* Update onnxruntime to v1.20.0
* Contributors: qiayuanl

2.2.0 (2025-05-26)
------------------

2.1.1 (2025-05-01)
------------------
* Merge branch 'refs/heads/master' into feature/lio_fuse
* Contributors: qiayuanl

2.1.0 (2025-04-28)
------------------
* Merge pull request `#2 <https://github.com/qiayuanl/legged_control2/issues/2>`_ from qiayuanl/feature/lio_fuse
  Feature/lio fuse
* Correct the JointPositionsObservationTerm in new default position defination
* Adjust the RlController for new ControllerBase
* Adjust the RlController for new ControllerBase
* Correct the usage of linear velocity state estimation result!
* Contributors: Qiayuan Liao, qiayuanl

2.0.0 (2025-04-08)
------------------
* Minor changes for comments of OnnxPolicy
* Minor changes for LastActionObservationTerm and constructor of OnnxPolicy
* Contributors: qiayuanl

1.4.0 (2025-04-02)
------------------
* Merge branch 'feature/seprate_onnx_controller'
* Add Policy and OnnxController
* Rename OnnxController to RlController
* Contributors: qiayuanl

1.3.1 (2025-04-01)
------------------
* Add history_by_terms for OnnxController
* Contributors: qiayuanl

1.3.0 (2025-03-29)
------------------
* Add observation history support
* Contributors: qiayuanl

1.2.1 (2025-03-29)
------------------
* Add and run pre-commit
* Contributors: qiayuanl

1.2.0 (2025-03-28)
------------------

1.1.0 (2025-03-26)
------------------
* Add some info for the command and observation size
* Add missing header
* Add virtual for parserObservation and parserCommand
* Correct BaseAngVelObservationTerm
* Update OnnxController with Manger
* Add ManagerBased, CommandManager, ObservationManager
* Add OnnxPolicy
* Add phase_hold
* Check if jointNameInPolicy\_ in jointIndexMap\_
* Minor change for formate
* Add virtual for OnnxController
* Correct phase cycle
* Add phase observation
* Remove config and launch of legged_rl_controllers
* Replace onnxruntime with onnxruntime_ament
* Add position_delta action type
* Add action_type from parameter
* Read from observation from parameter
* Use new hardware interface
* Print shape of onnx policy for debugging
* Add joint_names parameters interface
* Add joint_names parameters interface
* Add default_position and kp, kd parameters interface
* Correct naming of controllers plugin
* Add publisher for policy IO
* Add StandbyController
* Fix some minor problems
* Add param interface for LinearKalmanFilter
* Add param interface for LeggedModelRos2
* Add teleop.launch.py
* Replace all ZYX with quaternion
* Add cmd_vel receiver
* Fix a silly bug cause by copilot
* Correct the policy update rule and observation
* Add legged_rl_controllers
* Contributors: qiayuanl
