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

To be able to run the application, Qt >= 5.0 is required. See [this](https://doc.qt.io/qt-5/gettingstarted.html) link for installation guidelines. We recommend using Qt Creator to run the project, although it can be built manually as well by doing the following:

After Qt has been installed, clone the repository and run the following (assuming "qmake" is on PATH):

```
cd ShiftBaseStation
qmake
```

This will build the project and generate an executable file in debug/profile/release directory (depending on your build configuration). See [this](https://doc.qt.io/archives/3.3/qmake-manual-8.html) link for how to use the qmake command,
