#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QMetaType>
#include <QDebug>
#include <QThread>
#include "datamanager.h"
#include <QElapsedTimer>

void addData()
{

}

int main(int argc, char *argv[])
{
    // TODO: Move these to other file
    qmlRegisterType<DataManager>("shift.datamanagement", 1, 0, "DataManager");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) {
            QCoreApplication::exit(-1);
        }
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
