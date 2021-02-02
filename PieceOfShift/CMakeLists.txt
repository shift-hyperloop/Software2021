cmake_minimum_required(VERSION 3.10)

project(PieceOfShift)

# Find includes in corresponding build directories
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

if(WIN32)
        # NOTE: CHANGE TO YOUR OWN QT PATH IF RUNNING ON WINDOWS
        set(CMAKE_PREFIX_PATH "C:\\Qt\\5.15.2\\msvc2019_64")
endif()

# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(WIN32)
  # NOTE: Change to Qt Path if on Windows
  set(CMAKE_PREFIX_PATH "C:\\Qt\\5.15.1\\msvc2019_64")
endif()

find_package(Qt5Core REQUIRED)
find_package(Qt5Quick REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5Concurrent REQUIRED)
find_package(Qt5QuickControls2 REQUIRED)

file(GLOB_RECURSE SOURCE_FILES
  "${PROJECT_SOURCE_DIR}/src/*.cpp"
  )

file(GLOB_RECURSE HEADER_FILES
  "${PROJECT_SOURCE_DIR}/src/*.h"
  )

file(GLOB_RECURSE QML
  "${PROJECT_SOURCE_DIR}/src/Frontend/*.qml"
  )

file(GLOB_RECURSE ASSETS
  "${PROJECT_SOURCE_DIR}/assets/*"
  )

file(COPY ${QML}
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

 file(COPY ${ASSETS}
      DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

add_executable(PieceOfShift ${HEADER_FILES} ${SOURCE_FILES} ${QML})

target_compile_definitions(PieceOfShift
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(PieceOfShift
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::Concurrent Qt${QT_VERSION_MAJOR}::QuickControls2)

