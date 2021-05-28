
#include "filehandler.h"
#include "Processing/plotdata.h"

#include <QDataStream>
#include <QDateTime>
#include <QDebug>
#include <QFile>
#include <QMap>
#include <QRegExp>

FileHandler::FileHandler() {}

FileHandler::~FileHandler() {}

void FileHandler::writeLogFile(const QString &path, const PlotData* plotData)
{
    QFile file(path);

    if (!file.open(QIODevice::WriteOnly)) {
        qDebug() << "Could not write to file:" << path << "Error string:" << file.errorString();
        return;
    }

    // Setting version in case there is change with Qt serialization
    QDataStream out(&file);
    out.setVersion(QDataStream::Qt_5_15);

    for (QString name : plotData->names()) {
        QVector<double> times = plotData->getXValues(name);
        QVector<QVariant> values = plotData->getYValues(name);
        int size = times.size(); // times.size() = values.size()

        out << name;
        out << size;

        for (unsigned int i = 0; i < size; i++) {
            out << (int) times.at(i);
            out << values.at(i);
        }
    }

    qDebug() << "File has been written with path: " << path;
    file.flush();
    file.close();
}

// Reads a file from given path
std::unique_ptr<PlotData> FileHandler::readLogFile(const QString &path)
{
    QFile file(path);
    std::unique_ptr<PlotData> plotData(new PlotData());

    QDataStream in(&file);

    // Setting version in case there is change with Qt serialization
    in.setVersion(QDataStream::Qt_5_15);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Could not read log file: " << path << " Error string: " << file.errorString();
        return plotData;
    }

    while (!in.atEnd()) {
        QString name;
        int dataSize;

        in >> name;
        in >> dataSize;

        for (unsigned int i = 0; i < dataSize; i++) {

            int time;
            QVariant value;

            in >> time;
            in >> value; 

            plotData->addData(name, time, value);
        }
    }

    qDebug() << "File finished reading";
    return std::move(plotData);
}

