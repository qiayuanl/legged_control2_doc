.. index:: pair: page; Sim-to-real
.. _doxid-legged_control2_doc_sim-to-real:

Sim-to-real
============


Run on Ubuntu 22.04
~~~~~~~~~~~~~~~~~~~~~~~~~~

After Sim-to-sim, you can continue with the sim-to-real part.

- Install Unitree hardware dependency (SDKs):

  .. code-block:: bash

    # Install the sim2real required pkg from apt
    sudo apt-get install ros-humble-unitree-systems
    sudo apt-get update

- Acquire the network interface:

  .. code-block:: bash

    ifconfig

  |ifconfig|

  .. |ifconfig| image:: ./img/ifconfig.png
    :scale: 35
    :alt: ifconfig cannot be displayed!
    :target: ./img/ifconfig.png
    :class: no-scaled-link

- Run:

  .. code-block:: bash
    
    cd ~/colcon_ws
    source install/setup.zsh
    ros2 launch unitree_description real.launch.py robot_type:=g1 network_interface:=enp0s31f6


Run with Docker for Ubuntu 20.04, 18.04
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Create a colcon workspace:

  .. code-block:: bash

    mkdir -p ~/colcon_ws/src && cd ~/colcon_ws/src
    git clone git@github.com:qiayuanl/unitree_ros2.git

- Pull the real-deploy Docker:

  .. code-block:: bash
    
    docker pull qiayuanl/unitree:latest

- Run the Docker:

  .. code-block:: bash
    
    docker run -it --name runtime --privileged --restart always --network host -v /dev/input:/dev/input -v ~/colcon_ws:/colcon_ws qiayuanl/unitree:latest zsh

  If add `--restart always`, then the docker will auto-restart when you reboot

- Run:

  .. code-block:: bash

    ros2 launch unitree_description real.launch.py robot_type:=g1 network_interface:=enp0s31f6

  Then you can switch the controller with rqt or Jotstick.