# Install script for directory: /home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/opencv4/samples/cpp" TYPE FILE FILES
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/3calibration.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/CMakeLists.txt"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/application_trace.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/bgfg_segm.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/calibration.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/camshiftdemo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/cloning_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/cloning_gui.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/connected_components.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/contours2.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/convexhull.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/cout_mat.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/create_mask.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/dbt_face_detection.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/delaunay2.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/demhist.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/detect_blob.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/detect_mser.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/dft.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/digits.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/dis_opticalflow.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/distrans.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/drawing.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/edge.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/ela.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/em.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/facedetect.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/facial_features.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/falsecolor.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/fback.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/ffilldemo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/filestorage.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/fitellipse.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/grabcut.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/image_alignment.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/imagelist_creator.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/imagelist_reader.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/inpaint.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/kalman.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/kmeans.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/laplace.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/letter_recog.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/lkdemo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/logistic_regression.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/mask_tmpl.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/matchmethod_orb_akaze_brisk.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/minarea.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/morphology2.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/neural_network.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/npr_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/opencv_version.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/pca.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/peopledetect.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/phase_corr.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/points_classifier.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/polar_transforms.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/qrcode.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/segment_objects.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/select3dobj.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/simd_basic.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/smiledetect.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/squares.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/stereo_calib.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/stereo_match.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/stitching.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/stitching_detailed.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/train_HOG.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/train_svmsgd.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/travelsalesman.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/tree_engine.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/videocapture_basic.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/videocapture_camera.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/videocapture_gphoto2_autofocus.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/videocapture_gstreamer_pipeline.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/videocapture_image_sequence.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/videocapture_intelperc.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/videocapture_openni.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/videocapture_starter.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/videowriter_basic.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/warpPerspective_demo.cpp"
    "/home/iam/sub_proj/openCV_face/opencv/opencv-4.1.2/samples/cpp/watershed.cpp"
    )
endif()

