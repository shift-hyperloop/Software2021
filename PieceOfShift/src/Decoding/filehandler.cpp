
#include "filehandler.h"

#include <QDebug>
#include <QDateTime>
#include <QRegExp>
#include <QFile>
#include <QDataStream>
#include <QMap>


FileHandler::FileHandler() {}

FileHandler::~FileHandler() {}

// Reads a file from given path
void FileHandler::readLogFile(QString path) {

    QFile file(path);

    QMap<QString, QString> map;
    QDataStream in(&file);

    // Setting version in case there is change with Qt serialization
    in.setVersion(QDataStream::Qt_5_12);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        return;
    }

    // TODO 
    // De-serialize map/ sending onwards
    in >> map;

    qDebug() << "File finished reading";
}


// TODO 
// QMap should be QMap<QString, QQueue<QVariant>> dataCopyMap, also change in header file
void FileHandler::writeLogFile(QString path) {

    QFile file(path);

    if (!file.open(QIODevice::WriteOnly)) {
        qDebug() << "Could not write to file:" << path << "Error string:" << file.errorString();
        return;
    }

    // Setting version in case there is change with Qt serialization
    QDataStream out(&file);
    out.setVersion(QDataStream::Qt_5_12);
    out << dataCopyMap;


    qDebug() << "File has been written with path: " << path;
    file.flush();
    file.close();
}