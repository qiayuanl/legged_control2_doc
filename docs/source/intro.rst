.. index:: pair: page; Introduction

Introduction
============

**legged_control2** is a controller designed for legged robots, built on top of **ROS2 Control**. 
It facilitates the easy deployment of Reinforcement Learning (RL) policies on real-world robots.
This toolbox is implemented in C++, ensuring high-performance, real-time control for demanding robotic tasks.

To deploy an RL policy for sim-to-real, we should first perform **sim-to-sim** validation. 
If everything works well, we can proceed to **sim-to-real** testing.
Therefore, this document will first introduce how to use this toolbox for **sim-to-sim** validation, 
followed by a guide on conducting **sim-to-real** testing.


**legged_control2** is divided into two main parts: **legged_control2** and **unitree_ros2**.

- **legged_control2**: Includes state estimation and controllers for legged robots.
- **unitree_ros2**: Contains APIs related to Unitree hardware as well as URDF and launch files.

.. code-block:: console

   Legged_control2
   ├── legged_control2              # controller-related
   |    └── legged_rl_control       # User-defined controller!
   └── unitree_ros2                 # Unitree_hardware-related
        └── unitree_description     # Urdf & launch files


As we build the toolbox with **ROS2 Humble**, for Ubuntu 22.04 user, you can directly build and run.

For Ubuntu 18.04 and 20.04 user, you should can Docker.


|GitHub| Source code on GitHub: `qiayuanl/legged_control2 <https://github.com/qiayuanl/legged_control2>`_

  .. |GitHub| image:: ./img/GitHub-Mark-120px-plus.png
     :scale: 25
     :alt: GitHub logo cannot be displayed!
     :target: ./img/GitHub-Mark-120px-plus.png
     :class: no-scaled-link