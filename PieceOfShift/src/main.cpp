#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "Decoding/cansplitter.h"
#include "Processing/datamanager.h"

int main(int argc, char *argv[])
{
    QDirIterator it(":", QDirIterator::Subdirectories);
    // TODO: Move these to other file
    qmlRegisterType<DataManager>("shift.datamanagement", 1, 0, "DataManager");
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