#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QMetaType>
#include <QDebug>
#include <QAction>
#include "VelocityProcessingUnit.h"

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

    VelocityProcessingUnit vpu;
    for (unsigned int i = 0; i < 100; i++) {
        VelocityStruct* vs = new VelocityStruct();
        vs->velocity = static_cast<double>(i*10);
        vpu.addData(*vs);
    }
    vpu.process();
    qInfo("Something");

    engine.load(url);

    return app.exec();
}
