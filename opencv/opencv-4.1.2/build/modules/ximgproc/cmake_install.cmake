# Install script for directory: /home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc

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

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xlibsx" OR NOT CMAKE_INSTALL_COMPONENT)
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so.4.1.2"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so.4.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "/usr/local/lib/aarch64-linux-gnu")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu" TYPE SHARED_LIBRARY OPTIONAL FILES
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib/libopencv_ximgproc.so.4.1.2"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib/libopencv_ximgproc.so.4.1"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so.4.1.2"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so.4.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHANGE
           FILE "${file}"
           OLD_RPATH "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib:"
           NEW_RPATH "/usr/local/lib/aarch64-linux-gnu")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so"
         RPATH "/usr/local/lib/aarch64-linux-gnu")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu" TYPE SHARED_LIBRARY FILES "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib/libopencv_ximgproc.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so"
         OLD_RPATH "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib:"
         NEW_RPATH "/usr/local/lib/aarch64-linux-gnu")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_ximgproc.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/brightedges.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/color_match.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/deriche_filter.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/disparity_filter.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/edge_filter.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/edgeboxes.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/edgepreserving_filter.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/estimated_covariance.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/fast_hough_transform.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/fast_line_detector.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/fourier_descriptors.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/lsc.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/paillou_filter.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/peilin.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/ridgefilter.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/run_length_morphology.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/seeds.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/segmentation.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/slic.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/sparse_match_interpolator.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/structured_edge_detection.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/ximgproc" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/include/opencv2/ximgproc/weighted_median_filter.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xsamplesx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/opencv4/samples/ximgproc" TYPE FILE FILES
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/CMakeLists.txt"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/brightedgesexample.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/color_match_template.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/colorize.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/dericheSample.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/deriche_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/disparity_filtering.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/edgeboxes_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/edgeboxes_demo.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/edgepreserving_filter_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/fast_hough_transform.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/filterdemo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/findredlinedpolygonfromgooglemaps.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/fld_lines.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/fourier_descriptors_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/fourier_descriptors_demo.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/graphsegmentation_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/live_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/niblack_thresholding.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/paillou_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/peilin.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/peilin_plane.png"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/peilin_shape.png"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/polygonstanfordoutput.png"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/run_length_morphology_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/seeds.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/selectivesearchsegmentation_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/selectivesearchsegmentation_demo.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/slic.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/stanford.png"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/structured_edge_detection.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/ximgproc/samples/thinning.cpp"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xsamplesx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/opencv4/samples/ximgproc" TYPE DIRECTORY FILES "")
endif()

