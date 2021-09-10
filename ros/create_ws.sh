#!/bin/bash

cd ~
mkdir ros_learn

cd ros_learn

mkdir -p catkin_service/src

cd catkin_service/src

catkin_init_workspace

catkin_create_pkg beginner_tutorials roscpp rospy std_msgs std_srv message_generation
