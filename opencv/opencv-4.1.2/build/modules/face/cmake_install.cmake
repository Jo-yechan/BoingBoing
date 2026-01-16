# Install script for directory: /home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face

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
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so.4.1.2"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so.4.1"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      file(RPATH_CHECK
           FILE "${file}"
           RPATH "/usr/local/lib/aarch64-linux-gnu")
    endif()
  endforeach()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu" TYPE SHARED_LIBRARY OPTIONAL FILES
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib/libopencv_face.so.4.1.2"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib/libopencv_face.so.4.1"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so.4.1.2"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so.4.1"
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
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so"
         RPATH "/usr/local/lib/aarch64-linux-gnu")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu" TYPE SHARED_LIBRARY FILES "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib/libopencv_face.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so"
         OLD_RPATH "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/build/lib:"
         NEW_RPATH "/usr/local/lib/aarch64-linux-gnu")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/aarch64-linux-gnu/libopencv_face.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/include/opencv2/face.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/face" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/include/opencv2/face/bif.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/face" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/include/opencv2/face/face_alignment.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/face" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/include/opencv2/face/facemark.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/face" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/include/opencv2/face/facemarkAAM.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/face" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/include/opencv2/face/facemarkLBF.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/face" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/include/opencv2/face/facemark_train.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/face" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/include/opencv2/face/facerec.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/face" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/include/opencv2/face/mace.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xdevx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opencv4/opencv2/face" TYPE FILE OPTIONAL FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/include/opencv2/face/predict_collector.hpp")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xsamplesx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/opencv4/samples/face" TYPE FILE FILES
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/CMakeLists.txt"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/Facemark.java"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/facemark_demo_aam.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/facemark_demo_lbf.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/facemark_lbf_fitting.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/facerec_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/facerec_eigenfaces.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/facerec_fisherfaces.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/facerec_lbph.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/facerec_save_load.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/facerec_video.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/landmarks_demo.py"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/mace_webcam.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/sampleDetectLandmarks.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/sampleDetectLandmarksvideo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/sample_config_file.xml"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/sample_face_swapping.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/sample_train_landmark_detector.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/sample_train_landmark_detector2.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/samplewriteconfigfile.cpp"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xsamplesx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/opencv4/samples/face" TYPE DIRECTORY FILES "/home/iam/sub_proj/openCV_face/opencv/opencv_contrib-4.1.2/modules/face/samples/etc")
endif()

