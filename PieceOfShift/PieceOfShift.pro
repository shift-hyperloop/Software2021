QT += charts quick widgets concurrent quickcontrols2

CONFIG += c++14

SOURCES += \
        src/Decoding/managedatatype.cpp \
        src/Decoding/canspiltter.cpp \
        src/Decoding/poddatasender.cpp \
        src/Processing/accelerationprocessingunit.cpp \
        src/Processing/accelerationvelocityunit.cpp \
        src/Processing/datamanager.cpp \
        src/main.cpp \
        src/Processing/processingunit.cpp \
        src/Processing/velocityprocessingunit.cpp \


OTHER_FILES += \
    src/Frontend/*.qml \
    assets/images/*
RESOURCES += \
    assets/images/images.qrc \
    src/qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
    
HEADERS += \
    src/Decoding/managedatatype.h \
    src/Processing/accelerationprocessingunit.h \
    src/Processing/accelerationvelocityunit.h \
    src/Processing/datamanager.h \
    src/Processing/processingunit.h \
    src/Decoding/cansplitter.h \
    src/Decoding/poddatasender.h \
    src/Processing/velocityprocessingunit.h \
