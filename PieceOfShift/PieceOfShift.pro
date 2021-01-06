QT += charts quick widgets concurrent

CONFIG += c++14

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/Decoding/canspiltter.cpp \
        src/Processing/accelerationprocessingunit.cpp \
        src/Processing/accelerationvelocityunit.cpp \
        src/Processing/datamanager.cpp \
        src/main.cpp \
        src/Processing/processingunit.cpp \
        src/Processing/velocityprocessingunit.cpp

RESOURCES += qml.qrc \
    assets.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
    
DISTFILES += \
    futuristic_border.png

HEADERS += \
    src/Processing/accelerationprocessingunit.h \
    src/Processing/accelerationvelocityunit.h \
    src/Processing/datamanager.h \
    src/Processing/processingunit.h \
    src/Decoding/cansplitter.h \
    src/Processing/velocityprocessingunit.h
