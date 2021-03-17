QT += charts quick widgets concurrent quickcontrols2 core

CONFIG += c++14

SOURCES += \
        src/Decoding/decoder.cpp \
        src/Decoding/canserver.cpp \
        src/Decoding/filehandler.cpp \
        src/Processing/accelerationprocessingunit.cpp \
        src/Processing/accelerationvelocityunit.cpp \
        src/Processing/datamanager.cpp \
        src/main.cpp \
        src/Processing/processingunit.cpp \
        src/Processing/velocityprocessingunit.cpp
OTHER_FILES += \
   # src/Frontend/*.qml \
    assets/images/*
RESOURCES += \
    assets/images/images.qrc \
    src/qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
    
DISTFILES += \
    assets/images/* \
    #assets/images/Shift_Logo.png \
    src/Frontend/* \
    src/Frontend/DetailedBatteryPage.qml


for(f, DISTFILES):copyToDestdir($$files($${PWD}/$${f}))

HEADERS += \
    src/Decoding/decoder.h \
    src/Decoding/filehandler.h \
    src/Processing/accelerationprocessingunit.h \
    src/Processing/accelerationvelocityunit.h \
    src/Processing/datamanager.h \
    src/Processing/processingunit.h \
    src/Decoding/canserver.h \
    src/Processing/velocityprocessingunit.h \
    src/Processing/velocityprocessingunit.h
    
RC_ICONS = assets/images/icon.ico
