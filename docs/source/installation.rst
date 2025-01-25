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


From Debian Source (recommended)
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
