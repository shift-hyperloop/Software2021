# Software 2021

Code repository for the Software group for Team 2021

# Shift Base Station :computer: 

This repository contains the Shift Base Station System which has the purpose of:
- Fetching CAN messages from the pod via radio transmission
- Visualizing the CAN data for analysis
- Sending CAN signals to start/stop the pod via radio transmission

![Action Stat](https://github.com/shift-hyperloop/Software2021/workflows/Qt%20Build/badge.svg)
![Qt](https://camo.githubusercontent.com/01733e7677dabab55bd47062ade39c7e00944cf2536e5e9a7adeea2c19d97d6c/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f51742d716d616b652d677265656e2e737667)

## Installation

### Prerequisites

To be able to run the application, Qt >= 5.15 is recommended. See [this](https://doc.qt.io/qt-5/gettingstarted.html) link for installation guidelines. You can either use Qt Creator to build the project or any other build tool with CMake support.
Other required software:
- Git
- CMake (can be installed with Qt)
- Functioning C++ compiler supporting at least C++14.

Before building the project, clone it into a folder of your liking using the command:

HTTP:
```sh
$ git clone https://github.com/shift-hyperloop/Software2021.git
```

SSH:
```sh
$ git clone git@github.com:shift-hyperloop/Software2021.git
```

Or using a Git GUI application.

### Building the project

#### Windows

Before building the project you need to tell CMake where your Qt installation is. This can be done by changing this line in CMakeLists.txt:

```CMake
set(CMAKE_PREFIX_PATH "C:\\Qt\\5.15.2\\msvc2019_64")
```

To the path of your Qt installation and your preferred compiler. 

Now you can run CMake on the CMakeLists.txt file with your preferred kit and should be able to run the project.

#### Linux/Mac

After cloning the project, start by entering the project folder and create a build folder to store the build files using the commands (this can be created elsewhere if you prefer):

```sh
$ cd PieceOfShift
$ mkdir build
$ cd build
```

Then run CMake from the build folder:

```sh
$ cmake ..
```
You can now build the project using the command:
```sh
$ make

