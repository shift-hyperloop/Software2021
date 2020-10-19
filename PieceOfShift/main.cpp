#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QMetaType>
#include <QDebug>
#include <QAction>
#include "VelocityProcessingUnit.h"
#include "accelerationprocessingunit.h"
#include "accelerationvelocityunit.h"
#include <QElapsedTimer>

int main(int argc, char *argv[])
{
    // TODO: Move these to other file
    qmlRegisterType<VelocityProcessingUnit>("shift.datamanagement", 1, 0, "VelocityProcessingUnit");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) {
            QCoreApplication::exit(-1);
        }
    }, Qt::QueuedConnection);

    /*

    AccelerationProcessingUnit apu;
    for (unsigned int i = 1; i < 10000; i++) {
        AccelerationStruct* as = new AccelerationStruct();
        as->acceleration = static_cast<double>(i);
        apu.addData(*as);

    }
    for (unsigned int i = 1; i < 10000; i++) {
        AccelerationStruct* as = new AccelerationStruct();
        as->acceleration = static_cast<double>(i);
        apu.addData(*as);

    }
    apu.process();
*/

    AccelerationVelocityUnit avu;
    AccelerationProcessingUnit apu;
    VelocityProcessingUnit vpu;
    for (unsigned int i = 1; i < 100; i++) {
        VelocityStruct* vs = new VelocityStruct();
        vs->velocity = static_cast<double>(i*3);
        AccelerationStruct* as = new AccelerationStruct();
        as->acceleration= static_cast<double>(i*2);
        avu.addData(*as, *vs);
        apu.addData(*as);
        vpu.addData(*vs);
    }
    avu.process();
    apu.process();
    vpu.process();

/*
    VelocityProcessingUnit vpu;
    for (unsigned int i = 1; i < 2; i++) {
        VelocityStruct* vs = new VelocityStruct();
        vs->velocity = static_cast<double>(i*10);
        vpu.addData(*vs);
    }
    vpu.process();
    qInfo("Something");

*/
    engine.load(url);

    return app.exec();
}
