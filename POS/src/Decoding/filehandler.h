#pragma once
#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>
#include <QVector>
#include <QByteArray>

class FileHandler : public QObject
{
    Q_OBJECT
public:
    FileHandler();
    ~FileHandler();

public:
    void writeLogFile(QString path);
    QMap<QString, QPair<QVector<double>*, QVector<QVariant>*>> readLogFile(QString path);
};

#endif // FILEHANDLER_H