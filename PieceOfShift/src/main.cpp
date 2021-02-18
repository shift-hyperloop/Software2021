#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "Processing/datamanager.h"
#include "Decoding/decoder.h"

int main(int argc, char *argv[])
{
    // TODO: Move these to other file

    /* Make QML able to access dataManager from any file through DataManagerAccessor object */
    DataManager dataManager;
    qRegisterMetaType<DataManager*>();

    DataManagerAccessor::setDataManager(&dataManager);
    qmlRegisterType<DataManagerAccessor>("shift.datamanagement", 1, 0, "DataManagerAccessor");


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
