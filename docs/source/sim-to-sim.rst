.. index:: pair: page; Sim-to-sim
.. _doxid-legged_control2_doc_sim-to-sim:

Sim-to-sim
============

The **legged_control2** library is written in C++ and build on Ubuntu 22.04
If you use Ubuntu 20.04 or 18.04, then you need to run in the Docker, Please see *Installation with Docker*

Installation (for Ubuntu 22.04)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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


Installation with Docker (for Ubuntu 20.04, 18.04)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For Ubuntu 18.04 and Ubuntu 20.04, you should use Docker for ROS2.

Install Docker
--------------

- Check if you have installed Docker:

  .. code-block:: bash

    sudo docker --version


- If NOT, install it:

  .. code-block:: bash

    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install docker-ce
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo docker --version
    sudo usermod -aG docker $USER


Run the sim2sim docker
-----------------------

- Create a colcon workspace, and build it:

  .. code-block:: bash

    mkdir -p ~/colcon_ws/src && cd ~/colcon_ws/src
    git clone git@github.com:qiayuanl/unitree_ros2.git

- Get the docker:

  .. code-block:: bash

    docker pull gaoyuman/ros2-gazebo  


- Run the Docker:

  .. code-block:: bash

    xhost +local:docker

    docker run -it --name test --privileged --network host \
    --env DISPLAY=$DISPLAY \
    --env QT_X11_NO_MITSHM=1 \
    --env PULSE_SERVER=unix:/run/user/$(id -u)/pulse/native \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse \
    --volume /var/lib/dbus:/var/lib/dbus \
    --volume /dev/input:/dev/input \
    --device /dev/snd:/dev/snd \
    -v ~/colcon_ws:~/colcon_ws \
    gaoyuman/ros2-gazebo:latest zsh

    cd ~/colcon_ws/src
    colcon build --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -G Ninja -DCMAKE_BUILD_TYPE=RelwithDebInfo --event-handlers console_direct+ --packages-up-to unitree_description

  When you reboot, the docker will stop. You can restart it and enter:

  .. code-block:: bash

    docker start test
    docker exec -it test zsh




Run it!
~~~~~~~~~~~~~

- Enter the docker (for docker user)

  .. code-block:: bash

    docker start test
    docker exec -it test zsh


- Launch it with Gazebo:

  .. code-block:: bash

    cd ~/colcon_ws
    source install/setup.zsh
    ros2 launch unitree_description gazebo.launch.py robot_type:=<your-robot-type>

  <your-robot-type> can be g1 or go1 now.

  |g1|

  .. |g1| image:: ./img/g1.png
     :scale: 30
     :alt: g1 cannot be displayed!
     :target: ./img/g1.png
     :class: no-scaled-link

  |go1|

  .. |go1| image:: ./img/go1.png
     :scale: 36
     :alt: go1 cannot be displayed!
     :target: ./img/go1.png
     :class: no-scaled-link

- Switch between controllers:

  .. code-block:: bash

    rqt

  Load `controller plugin` in rqt, right click to config & load different controllers.

  To publish velocity command, you can choose topic `/cmd_vel` , then change the lin_vel & ang_vel, and publish the topic

  |rqt|

  .. |rqt| image:: ./img/rqt.png
     :scale: 30
     :alt: rqt cannot be displayed!
     :target: ./img/rqt.png
     :class: no-scaled-link


- Enable the Joystick: (Optional)
  
  .. code-block:: bash

    ros2 launch unitree_description teleop.launch.py

  Then you can use the Joystick to switch between controllers and publish commands.


- Visualize in Rviz2 (Optional)

  .. code-block:: bash

    rviz2

  Choose odom as the frame and Load the RobotModel topic 

  |rviz|

  .. |rviz| image:: ./img/rviz.png
     :scale: 30
     :alt: rviz cannot be displayed!
     :target: ./img/rviz.png
     :class: no-scaled-link


Make your own legged-rl-controllers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


If you `sudo apt-get install ros-humble-legged-rl-controllers` as installation, then you use the default controller.

If you want to make your own legged-rl-controllers, first remove the default one:

  .. code-block:: bash

    sudo apt remove ros-humble-legged-rl-controllers

Then create your own controller repo from the template `repo`_ we provide:

.. _`repo`: https://github.com/qiayuanl/legged_template_controller

DO NOT FORK, Click `Use this template` button and create your controller.

You can make your Onnxcontroller with user’s RL policy as Onnx files.

Compile:

.. code-block:: bash
  
  colcon build --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -G Ninja -DCMAKE_BUILD_TYPE=RelwithDebInfo --event-handlers console_direct+ --packages-up-to <your-pkg-name>
