#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>
#include <QVector>
#include <QList>
#include <QByteArray>

class FileHandler : public QObject
{
    Q_OBJECT
public:
    FileHandler();
    ~FileHandler();
public slots:
    void writeLogFile(QString path, QMap<QString, QString> dataCopyMap);
    void readLogFile(QString path);

private:
    void dummyData(QString path);

};

#endif // FILEHANDLER_H
