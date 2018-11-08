FROM osrf/ros:kinetic-desktop-full

LABEL maintainer="Sebastian Höffner <shoeffner@tzi.de>"

ENV ROS_MASTER_URI http://roscore:11311

EXPOSE 9090 11311

# Install dependencies
RUN apt-get update \
    # Accept nao-meshes license
    && echo "ros-nao-meshes ros-nao-meshes/accepted-ros-nao-meshes boolean true" | debconf-set-selections \
    && apt-get install -y ros-${ROS_DISTRO}-rosbridge-server \
                          ros-${ROS_DISTRO}-nao-meshes \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash && source /catkin_ws/devel/setup.bash" >> ${HOME}/.bashrc

# Copy workspace and initialize it
COPY .rosinstall /catkin_ws/src/.rosinstall
COPY ros_entrypoint.sh start_after_rosmaster.sh /
WORKDIR /catkin_ws
RUN /ros_entrypoint.sh wstool update -t src \
    && /ros_entrypoint.sh rosdep update \
    && /ros_entrypoint.sh rosdep install -y --ignore-src --from-paths src/

# Copy naosharp package and compile everything
COPY naosharp /catkin_ws/src/naosharp
RUN /ros_entrypoint.sh catkin_make

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["roscore"]
