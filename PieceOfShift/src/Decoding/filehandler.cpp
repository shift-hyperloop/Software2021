
#include "filehandler.h"
#include "Processing/plotdata.h"

#include <QDebug>
#include <QDateTime>
#include <QRegExp>
#include <QFile>
#include <QDataStream>
#include <QMap>



FileHandler::FileHandler() {}

FileHandler::~FileHandler() {}

// Reads a file from given path
// TODO fix serialization 
QMap<QString, QPair<QVector<double>*, QVector<QVariant>*>> readLogFile(QString path) {

    QFile file(path);

    QMap<QString, QPair<QVector<double>*, QVector<QVariant>*>> map;

    QDataStream in(&file);

    // Setting version in case there is change with Qt serialization
    in.setVersion(QDataStream::Qt_5_12);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        return map;
    }

    in >> map;
    qDebug() << "File finished reading";
    return map;

    // TODO 
    // De-serialize map/ sending onwards
   //  in >> map;

}


// TODO fix serialization 
void FileHandler::writeLogFile(QString path) {

    QFile file(path);

    if (!file.open(QIODevice::WriteOnly)) {
        qDebug() << "Could not write to file:" << path << "Error string:" << file.errorString();
        return;
    }

    QMap<QString, QPair<QVector<double>*, QVector<QVariant>*>> dataCopyMap;
    PlotData plotdata;
    dataCopyMap = plotdata.dataMap();

    // Setting version in case there is change with Qt serialization
    QDataStream out(&file);
    out.setVersion(QDataStream::Qt_5_12);
    qInfo() << out;
    out << dataCopyMap;


    qDebug() << "File has been written with path: " << path;
    file.flush();
    file.close();
}
