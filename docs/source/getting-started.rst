.. index:: pair: page; Getting Started

.. _doxid-legged_control2_doc_getting_started:

Getting Started
===============
We provided two examples to help you get started with the Unitree Go1 sim-to-sim and sim-to-real.

Running the Unitree Go1 in MuJoCo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Make sure that you have installed the basic package of ``legged_control2`` as well as ``mujuco_ros2_control``.

- Clone the ``unitree_ros2`` package, which consists of two pacakge:\

  * **unitree_description**: URDF, launch, config files, needed for both sim-to-sim and sim-to-real.
  * **unitree_systems**: Hardware interface for Unitree SDK1/2, **only needed for sim-to-real**.

  We only build the ``unitree_description`` package for sim-to-sim. (TODO: seprate to two repo)

  .. code-block:: bash

    mkdir -p ~/colcon_ws/src && cd ~/colcon_ws/src
    git clone git@github.com:qiayuanl/unitree_ros2.git
    cd ~/colcon_ws
    colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelwithDebInfo -packages-up-to unitree_description
    source install/setup.bash

- Some visualization tools are useful but not necessary:

  .. code-block:: bash

    sudo apt-get install ros-humble-ros2-controllers ros-humble-rqt ros-humble-rqt-controller-manager ros-humble-rqt-publisher ros-humble-rviz2

- Launch the simulation:

  .. code-block:: bash

    ros2 launch unitree_description mujoco.launch.py robot_type:='go1'

- Switch between controllers:

  .. code-block:: bash

    rqt

  Load `controller plugin` in rqt, right click to config & load different controllers.

Running the Unitree Go1 in Real
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

