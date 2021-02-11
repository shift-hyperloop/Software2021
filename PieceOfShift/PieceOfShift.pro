QT += charts quick widgets concurrent quickcontrols2 core

CONFIG += c++14

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Copies the given files to the destination directory
defineTest(copyToDestdir) {
    files = $$1

    for(FILE, files) {
        DDIR = $$DESTDIR

        # Replace slashes in paths with backslashes for Windows
        win32:FILE ~= s,/,\\,g
        win32:DDIR ~= s,/,\\,g

        QMAKE_POST_LINK += $$QMAKE_COPY $$quote($$FILE) $$quote($$DDIR) $$escape_expand(\\n\\t)
    }

    export(QMAKE_POST_LINK)
}

SOURCES += \
        src/Decoding/canspiltter.cpp \
        src/Decoding/filehandler.cpp \
        src/Decoding/poddatasender.cpp \
        src/Processing/accelerationprocessingunit.cpp \
        src/Processing/accelerationvelocityunit.cpp \
        src/Processing/datamanager.cpp \
        src/main.cpp \
        src/Processing/processingunit.cpp \
        src/Processing/velocityprocessingunit.cpp

OTHER_FILES += \
    src/Frontend/*.qml \
    assets/images/*

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
    
DISTFILES += \
    assets/images/* \
    #assets/images/Shift_Logo.png \
    src/Frontend/* \


for(f, DISTFILES):copyToDestdir($$files($${PWD}/$${f}))

HEADERS += \
    src/Decoding/filehandler.h \
    src/Processing/accelerationprocessingunit.h \
    src/Processing/accelerationvelocityunit.h \
    src/Processing/datamanager.h \
    src/Processing/processingunit.h \
    src/Decoding/cansplitter.h \
    src/Decoding/poddatasender.h \
    src/Processing/velocityprocessingunit.h

RESOURCES +=
