# Install script for directory: /home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RELEASE")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xsamplesx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/opencv4/samples/python" TYPE FILE PERMISSIONS OWNER_READ GROUP_READ WORLD_READ FILES
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/_coverage.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/_doc.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/asift.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/browse.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/calibrate.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/camera_calibration_show_extrinsics.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/camshift.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/coherence.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/color_histogram.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/common.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/contours.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/deconvolution.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/demo.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/dft.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/digits.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/digits_adjust.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/digits_video.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/dis_opt_flow.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/distrans.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/edge.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/facedetect.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/feature_homography.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/find_obj.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/fitline.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/floodfill.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/gabor_threads.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/gaussian_mix.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/grabcut.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/hist.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/houghcircles.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/houghlines.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/inpaint.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/kalman.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/kmeans.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/lappyr.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/letter_recog.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/lk_homography.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/lk_track.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/logpolar.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/morphology.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/mosse.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/mouse_and_match.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/mser.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/opencv_version.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/opt_flow.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/peopledetect.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/plane_ar.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/plane_tracker.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/squares.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/stereo_match.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/stitching.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/stitching_detailed.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/texture_flow.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/tst_scene_render.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/turing.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/video.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/video_threaded.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/video_v4l2.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/python/watershed.py"
    )
endif()

