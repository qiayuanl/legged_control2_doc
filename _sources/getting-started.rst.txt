.. index:: pair: page; Getting Started

.. _doxid-legged_control2_doc_getting_started:

Getting Started
===============
We provided two examples to help you get started with the Unitree Go1 sim-to-sim and sim-to-real.

You need to add the apt source of Unitree build farm to your system, and install the Unitree description packages, which contains the URDF, MJCF files, needed for both sim-to-sim and sim-to-real.

  .. code-block:: bash

      # Add apt source
      echo "deb [trusted=yes] https://github.com/qiayuanl/unitree_buildfarm/raw/noble-jazzy-amd64/ ./" | sudo tee /etc/apt/sources.list.d/qiayuanl_unitree_buildfarm.list
      echo "yaml https://github.com/qiayuanl/unitree_buildfarm/raw/noble-jazzy-amd64/local.yaml jazzy" | sudo tee /etc/ros/rosdep/sources.list.d/1-qiayuanl_unitree_buildfarm.list
      sudo apt-get update

      # Instsall description packages
      sudo apt-get install ros-jazzy-unitree-description

.. _doxid-legged_control2_doc_sim-to-sim:

Running the Unitree Go1 in MuJoCo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Make sure that you have installed the basic package of ``legged_control2`` as well as ``mujuco_ros2_control``.

- Clone and build the ``unitree_bringup`` package

  .. code-block:: bash

    mkdir -p ~/colcon_ws/src && cd ~/colcon_ws/src
    git clone git@github.com:qiayuanl/unitree_bringup.git
    cd ~/colcon_ws
    colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelwithDebInfo --packages-up-to unitree_bringup
    source install/setup.bash

- Some visualization tools are useful but not necessary:

  .. code-block:: bash

    sudo apt-get install ros-jazzy-ros2-controllers ros-jazzy-rqt ros-jazzy-rqt-controller-manager ros-jazzy-rqt-publisher ros-jazzy-rviz2

- Launch the simulation:

  .. code-block:: bash

    ros2 launch unitree_bringup mujoco.launch.py robot_type:='go1'

- Switch between controllers:

  .. code-block:: bash

    rqt

  Load `controller plugin` in rqt, right click to config & load different controllers.

Running the Unitree Go1 in Real
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Run on the user computer
------------------------

We can run all the software on the user computer, and use the EtherNet calbe to receive the readings and send the commands to the robot. This is a good way to test the software before deploying it on the robot.

- Install the Unitree hardware dependency (SDKs):

  .. code-block:: bash

    sudo apt-get install ros-jazzy-unitree-systems

- Follow the instructions in the :ref:`sim-to-sim <doxid-legged_control2_doc_sim-to-sim>` to clone and build the `unitree_bringup` package. Everything is the same except the launch file:

  ..  code-block:: bash

    ros2 launch unitree_bringup real.launch.py robot_type:='go1'


Run on the on-board computer
----------------------------



Writing your own controller
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Check template in `legged_template_controller <https://github.com/qiayuanl/legged_template_controller>`_ package.
