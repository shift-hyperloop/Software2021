cmake_minimum_required(VERSION 3.10)

project(PieceOfShift)

set(CMAKE_CXX_STANDARD 14)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick Widgets Concurrent REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Widgets Concurrent REQUIRED)

file(GLOB_RECURSE SOURCE_FILES
  "${PROJECT_SOURCE_DIR}/src/*.cpp"
  )

file(GLOB_RECURSE HEADER_FILES
  "${PROJECT_SOURCE_DIR}/src/*.h"
  )

add_executable(PieceOfShift ${HEADER_FILES} ${SOURCE_FILES} qml.qrc assets.qrc)

target_compile_definitions(PieceOfShift
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(PieceOfShift
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::Concurrent)

