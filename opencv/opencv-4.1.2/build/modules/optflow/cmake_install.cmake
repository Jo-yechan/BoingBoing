# Install script for directory: /home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow

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
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so.4.1.2"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so.4.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "/usr/local/lib/aarch64-linux-gnu")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu" TYPE SHARED_LIBRARY OPTIONAL FILES
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib/libopencv_optflow.so.4.1.2"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib/libopencv_optflow.so.4.1"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so.4.1.2"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so.4.1"
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
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so"
         RPATH "/usr/local/lib/aarch64-linux-gnu")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu" TYPE SHARED_LIBRARY FILES "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib/libopencv_optflow.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so"
         OLD_RPATH "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib:"
         NEW_RPATH "/usr/local/lib/aarch64-linux-gnu")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_optflow.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/include/opencv2/optflow.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/optflow" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/include/opencv2/optflow/motempl.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/optflow" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/include/opencv2/optflow/pcaflow.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/optflow" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/include/opencv2/optflow/rlofflow.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/optflow" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/include/opencv2/optflow/sparse_matching_gpc.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xsamplesx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/opencv4/samples/optflow" TYPE FILE FILES
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/gpc_evaluate.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/gpc_train.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/gpc_train_middlebury.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/gpc_train_sintel.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/motempl.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/motempl.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/optical_flow_benchmark.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/optical_flow_evaluation.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/pcaflow_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/simpleflow_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/optflow/samples/tvl1_optical_flow.cpp"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xsamplesx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/opencv4/samples/optflow" TYPE DIRECTORY FILES "")
endif()

