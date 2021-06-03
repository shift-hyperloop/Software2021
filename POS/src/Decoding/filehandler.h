#pragma once
#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QByteArray>
#include <QObject>
#include <QVector>

#include "Processing/plotdata.h"

class FileHandler : public QObject
{
    Q_OBJECT
public:
    FileHandler();
    ~FileHandler();

public:
    static void writeLogFile(const QString &path, const PlotData* plotData);
    static std::unique_ptr<PlotData> readLogFile(const QString &path);
};

#endif // FILEHANDLER_H
