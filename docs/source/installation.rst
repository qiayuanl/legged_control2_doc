.. index:: pair: page; Installation
.. _doxid-legged_control2_doc_installation:

Installation
============
Prerequisites
~~~~~~~~~~~~~

The legged_control2 library is written in C++. It is tested under Ubuntu 22.04 with library versions as provided in the package sources.

Source code
------------
The source code is hosted on GitHub: `qiayuanl/legged_control2 <https://github.com/qiayuanl/legged_control2>`_. 

    .. code-block:: bash
    
        # Clone legged_control2
        git clone git@github.com:qiayuanl/legged_control2.git


.. _doxid-legged_control2_doc_installation_legged_control2_doc_install:

Installation
~~~~~~~~~~~~


Debian Source (recommended)
--------------------------------

For Ubuntu 22.04 user, you can directly install the legged_control2 from the apt source.

- Add apt source:

    .. code-block:: bash

        # Add apt source
        echo "deb [trusted=yes] https://github.com/qiayuanl/legged_buildfarm/raw/jammy-humble-amd64/ ./" | sudo tee /etc/apt/sources.list.d/qiayuanl_legged_buildfarm.list
        echo "yaml https://github.com/qiayuanl/legged_buildfarm/raw/jammy-humble-amd64/local.yaml humble" | sudo tee /etc/ros/rosdep/sources.list.d/1-qiayuanl_legged_buildfarm.list
        sudo apt-get update

- Install basic packages:
    
      .. code-block:: bash
    
        sudo apt-get install ros-humble-legged-control2
        sudo apt-get install ros-humble-legged-controllers

- Install simulation packages (**Do not install in robot's on-board computer**):
    
      .. code-block:: bash
    
        sudo apt install ros-humble-mujoco-ros2-control # For MuJoCo
        sudo apt install ros-humble-legged-gazebo # For Gazebo

Docker
------

For Ubuntu 18.04 and 20.04 users, especially for Unitree on-board computer, you should use Docker.

We have pre-built Docker images for different specific robots. You can pull the image from Docker Hub. For more details, please refer to the TODO.


Build from Source
------------------

For Ubuntu 22.04 users, you can build from source.

- Create a new colcon workspace:


    .. code-block:: bash

        mkdir -p ~/colcon_ws/src && cd ~/colcon_ws/src

- Clone the source code:

    .. code-block:: bash

        git clone git@github.com:qiayuanl/legged_control2.git && cd ..
        
- Install dependencies:

    .. code-block:: bash

        rosdep install --from-paths src --ignore-src -r -y

- Build the workspace:

    .. code-block:: bash

        colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelwithDebInfo --packages-up-to legged_control2
