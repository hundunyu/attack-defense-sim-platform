#!/bin/bash
sh kill.sh 2>&1
sleep 3
cd ~/.ros/log
rm -rf *
cd -
ip_num=$(ifconfig | grep "inet addr" | wc -l)
if [ ${ip_num} -eq "2" ];then
    HOST_IP=$(ifconfig | grep "inet addr" | grep -v "127.0.0.1" | awk '{ print $2}' | awk -F: '{print $2}')
    echo ${HOST_IP}
else
    HOST_IP=$(ifconfig | grep "inet addr" | grep "127.0.0.1" | awk '{ print $2}' | awk -F: '{print $2}')
    echo ${HOST_IP}
fi
# HOST_IP=$(ifconfig  | grep "inet addr"| grep -v "127.0.0.1" | awk '{ print $2}' | awk -F: '{print $2}')
echo "loading env parameters..."
echo ROS MASTER IP is : $HOST_IP
export ROS_HOSTNAME=$HOST_IP
cd ~/catkin_ws/
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:~/catkin_ws/devel/lib
source ~/catkin_ws/devel/setup.bash
echo "loading gazebo world..."
roslaunch innok_heros_gazebo load_world_60x40.launch  &
sleep 5
sh load_bullet.sh 5 
sleep 5
echo "loading uav and car..."
roslaunch innok_heros_gazebo load_cars4_uavs6.launch  &
sleep 5
echo "launching judge system..."
roslaunch judge_system judge_system_car4_uav6.launch &
sleep 5
# A: uav1-3; B: uav1-3
sleep 30
sh src/uav_arm.sh 3 3 /dev/null 2>&1 &
echo "all uav are ready to takeoff..."
#sh load_bullet.sh 10 
sleep 10

echo "simulation platform ready..."
sleep 1
echo "simulation platform ready..."
sleep 1
echo "simulation platform ready..."
sleep 1
echo "simulation platform ready..."
sleep 1
echo "simulation platform ready..."
sleep 1
echo "simulation platform ready..."
sleep 1
echo "simulation platform ready..."
sleep 1
echo "simulation platform ready..."
sleep 1
echo "simulation platform ready..."
sleep 1
echo "simulation platform ready..."
wait

exit


