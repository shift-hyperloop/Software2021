#
# For basic cmake file structure see: http://doc.qt.io/qt-5/cmake-manual.html
#
cmake_minimum_required(VERSION 3.17)


project(POS)

# Find includes in corresponding build directories
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
add_compile_definitions(QCUSTOMPLOT_USE_OPENGL)

if(WIN32)
        # NOTE: CHANGE TO YOUR OWN QT PATH IF RUNNING ON WINDOWS
        set(CMAKE_PREFIX_PATH "C:\\Qt\\5.15.2\\msvc2019_64")
endif()

# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)

# Find the Qt libraries for Qt Quick/QML
find_package(Qt5 REQUIRED Network Qml Quick Core Widgets Concurrent QuickControls2 PrintSupport)

# add the qml.qrc file
qt5_add_resources(qml_QRC src/qml.qrc)
qt5_add_resources(assets_QRC assets/images/images.qrc)

# add source files
file(GLOB_RECURSE SOURCE
  "src/*.cpp"
  "include/qcustomplot/qcustomplot.cpp"
  )

file(GLOB_RECURSE HEADER
  "src/*.h"
  "include/qcustomplot/qcustomplot.h"
  )

include_directories("src")
include_directories("include/qcustomplot")

# Tell CMake to create the helloworld executable
add_executable(POS ${SOURCE} ${HEADER} ${qml_QRC} ${assets_QRC})

# Use the Qml/Quick modules from Qt 5.
target_link_libraries(POS Qt5::Network Qt5::Qml Qt5::Quick Qt5::Core Qt5::Widgets Qt5::Concurrent Qt5::QuickControls2 Qt5::PrintSupport)


# post-build steps
# copy all the Qt support files to the debug/release directories
# You really only need the proper qt redistibution dll's/files, but this copies everything for easier development. Trim files out as needed.
message("Copying required Qt libraries and binaries to output directory....")
#add_custom_command(TARGET helloworld POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_PREFIX_PATH}\\bin $<TARGET_FILE_DIR:helloworld>)

#add_custom_command(TARGET helloworld POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_PREFIX_PATH}\\plugins $<TARGET_FILE_DIR:helloworld>)

#add_custom_command(TARGET helloworld POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_PREFIX_PATH}\\qml $<TARGET_FILE_DIR:helloworld>)
