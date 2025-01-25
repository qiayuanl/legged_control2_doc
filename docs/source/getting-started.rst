.. index:: pair: page; Quick Start

.. _doxid-legged_control2_doc_getting_started:

Quick Start
===============
For Ubuntu 22.04 user, you can follow the **Quick Start** to try the **sim-to-sim** part.

- Add apt source:

  .. code-block:: bash

    # Add apt source
    echo "deb [trusted=yes] https://github.com/qiayuanl/legged_buildfarm/raw/jammy-humble-amd64/ ./" | sudo tee /etc/apt/sources.list.d/qiayuanl_legged_buildfarm.list
    echo "yaml https://github.com/qiayuanl/legged_buildfarm/raw/jammy-humble-amd64/local.yaml humble" | sudo tee /etc/ros/rosdep/sources.list.d/1-qiayuanl_legged_buildfarm.list
    echo "deb [trusted=yes] https://github.com/qiayuanl/unitree_buildfarm/raw/jammy-humble-amd64/ ./" | sudo tee /etc/apt/sources.list.d/qiayuanl_unitree_buildfarm.list
    echo "yaml https://github.com/qiayuanl/unitree_buildfarm/raw/jammy-humble-amd64/local.yaml humble" | sudo tee /etc/ros/rosdep/sources.list.d/1-qiayuanl_unitree_buildfarm.list
    sudo apt-get update


- Install dependency:

  .. code-block:: bash

    # Install the sim2sim required pkg from apt
    sudo apt-get install ros-humble-legged-rl-controllers ros-humble-legged-gazebo
    # Install the visualized pkg
    sudo apt install ros-humble-ros2-control ros-humble-ros2-controllers ros-humble-rqt ros-humble-rqt-controller-manager ros-humble-rqt-publisher ros-humble-rviz2
    # Install the compile tool pkg
    sudo apt install ninja-build

- Create a colcon workspace, and build it:

  .. code-block:: bash

    mkdir -p ~/colcon_ws/src && cd ~/colcon_ws/src
    git clone git@github.com:qiayuanl/unitree_ros2.git
    colcon build --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -G Ninja -DCMAKE_BUILD_TYPE=RelwithDebInfo --event-handlers console_direct+ --packages-up-to unitree_description
    cd ~/colcon_ws/src
    source install/setup.zsh

- Launch it!

  .. code-block:: bash

    ros2 launch unitree_description gazebo.launch.py robot_type:=g1

- Switch between controllers:

  .. code-block:: bash

    rqt

  Load `controller plugin` in rqt, right click to config & load different controllers.
