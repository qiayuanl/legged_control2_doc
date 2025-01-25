.. index:: pair: page; Overview

Overview
============

**legged_control2** is a  C++ toolbox for legged robots. It provides basic state estimation and observer for debugging and analysis, and a unified hardware interface that facilitates the easy deployment of Reinforcement Learning (RL) policies on real-world robots.
This toolbox is implemented in C++, built on top of ``pinocchio`` and ``ros2_control``, ensuring high-performance, real-time control for demanding robotic tasks.

**legged_control2** supports multiple robots by reading different URDF provided by the user, and supports sim-to-sim (training simulation to validation simulation) with MuJoCo and Gazebo. Hardware interfaces shown below are supported for sim-to-real transfer.

* **unitree_ros2**\: Hardware interface for Unitree SDK1/2, such as the Unitree Go1 and G1.
* **booster_ros2**\: Hardware interface for Booster robotics.
* **soem_ros2**\: Basic interface for robots using EtherCAT Bus.
* **cleardrive_ros2**\: Hardware interface based on SOEM for robots using ClearDrive, such as the Berkeley Humanoid.



How to use the legged_control2?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

legged_control2 can be easily installed on Ubuntu. The `source code`_ is also publicly available.
To get started with the legged_control2, please refer to the 
:ref:`Installation started <doxid-legged_control2_doc_installation>`, and
:ref:`Getting Started <doxid-legged_control2_doc_getting_started>` pages.

.. _`source code`: https://github.com/qiayuanl/legged_control2


|GitHub| Source code on GitHub: `qiayuanl/legged_control2 <https://github.com/qiayuanl/legged_control2>`_

  .. |GitHub| image:: ./img/GitHub-Mark-120px-plus.png
     :scale: 25
     :alt: GitHub logo cannot be displayed!
     :target: ./img/GitHub-Mark-120px-plus.png
     :class: no-scaled-link
