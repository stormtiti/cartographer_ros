-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  map_frame = "map",
  tracking_frame =  "base_link",
  published_frame = "base_odom",
  odom_frame = "base_odom",
  provide_odom_frame = false,   -- true the local, non-loop-closed, continuous pose will be published as the odom_frame in the map_frame.
  use_odometry_data = false,    -- if true => subscribe "odom" topic, but here I use ekf convert to base_odom frame inside tf
  use_constant_odometry_variance = false,
  constant_odometry_translational_variance = 0.,
  constant_odometry_rotational_variance = 0.,
  use_horizontal_laser = true,
  use_horizontal_multi_echo_laser = false,
  horizontal_laser_min_range = 0.05,
  horizontal_laser_max_range = 10.,
  horizontal_laser_missing_echo_ray_length = 10.,
  num_lasers_3d = 0,
  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 15.0,
  pose_publish_period_sec = 5e-3,
}

--MAP_BUILDER.use_trajectory_builder_2d = true
MAP_BUILDER.use_trajectory_builder_2d = true
TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true
TRAJECTORY_BUILDER_2D.use_imu_data = false
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.3
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(40.)
SPARSE_POSE_GRAPH.optimization_problem.huber_scale = 1e2
return options

-- rosbag filter L4.bag filter.bag "topic == '/scan' or topic == '/tf' and m.transforms[0].header.frame_id != 'map'"
