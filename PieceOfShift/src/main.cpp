#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <qqml.h>
#include "Decoding/canserver.h"
#include "Decoding/filehandler.h"
#include "Processing/datamanager.h"

int main(int argc, char *argv[])
{
    // TODO: Move these to other file

    /* Make QML able to access dataManager from any file through DataManagerAccessor object */
    DataManager dataManager;

    DataManagerAccessor::setDataManager(&dataManager);
    qmlRegisterType<DataManager>("shift.datamanagement", 1, 0, "DataManager");
    qmlRegisterType<DataManagerAccessor>("shift.datamanagement", 1, 0, "DataManagerAccessor");
    qmlRegisterType<CANServer>("shift.datamanagement", 1, 0, "PodCommand");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
   

    
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/Frontend/main.qml"));;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl) {
            QCoreApplication::exit(-1);
        }
    }, Qt::QueuedConnection);


    QQuickStyle::setStyle("Material");
    engine.load(url);

    return app.exec();
}
