# Software 2021

Code repository for the Software group for Team 2021

# Shift Base Station :computer: 

This repository contains the Shift Base Station System which has the purpose of:
- Fetching CAN messages from the pod via radio transmission
- Visualizing the CAN data for analysis
- Sending CAN signals to start/stop the pod via radio transmission

<img align="right" src="./docs/assets/release-it.gif?raw=true" height="280">

![Action Stat](https://github.com/shift-hyperloop/Software2021/workflows/Qt%20Build/badge.svg)
![Qt](https://camo.githubusercontent.com/01733e7677dabab55bd47062ade39c7e00944cf2536e5e9a7adeea2c19d97d6c/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f51742d716d616b652d677265656e2e737667)

## Installation

### Prerequisites

To be able to run the application, Qt >= 5.15 is recommended. See [this](https://doc.qt.io/qt-5/gettingstarted.html) link for installation guidelines. We recommend using Qt Creator to run the project, although it can be built manually as well.

Other required software:
- Git
- CMake (can be installed with Qt)
- Functioning C++ compiler supporting C++14.

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

### Using Qt Creator

To build the project using Qt Creator, first open it by opening "CMakeLists.txt" as a project. If building on Windows, the "CMAKE_PREFIX_PATH" variable in "CMakeLists.txt" might need to be changed to the location of your Qt installation. The project should now build successfully.

### Not using Qt Creator

After cloning the project, start by entering the project folder and create a build folder to store the build files using the commands:

```sh
$ cd PieceOfShift
$ mkdir build
$ cd build
```

Then run CMake from the build folder:

```sh
$ cmake ..
```

Depending on your platform and compiler, you now should have generated files to build the project. Run these to build the project.
