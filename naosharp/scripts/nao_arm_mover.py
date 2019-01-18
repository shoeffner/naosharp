#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist, Vector3


def talker():
    pub = rospy.Publisher('/nao/lelbow_link/cmd_vel', Twist, queue_size=10)
    rospy.init_node('naocommander', anonymous=True)
    rate = rospy.Rate(10)  # 10hz
    while not rospy.is_shutdown():
        twist_msg = Twist(Vector3(0, 0, 0), Vector3(5, 5, 5))
        rospy.loginfo(twist_msg)
        pub.publish(twist_msg)
        rate.sleep()


if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
