^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package legged_rl_controllers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
