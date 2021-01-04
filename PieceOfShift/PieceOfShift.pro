QT += charts quick widgets concurrent

CONFIG += c++14

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/Backend/canspiltter.cpp \
        src/Backend/accelerationprocessingunit.cpp \
        src/Backend/accelerationvelocityunit.cpp \
        src/Backend/datamanager.cpp \
        src/Backend/main.cpp \
        src/Backend/processingunit.cpp \
        src/Backend/velocityprocessingunit.cpp

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
    src/Backend/accelerationprocessingunit.h \
    src/Backend/accelerationvelocityunit.h \
    src/Backend/datamanager.h \
    src/Backend/processingunit.h \
    src/Backend/cansplitter.h \
    src/Backend/velocityprocessingunit.h
