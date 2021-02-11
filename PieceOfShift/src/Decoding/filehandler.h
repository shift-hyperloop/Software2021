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

    void writeToFile();
    // void sendDataToProcessor
    void readDataFromFile(QString);
    void sendData();


private:

public slots:
    // QList<QByteArray> getMessages();

signals:
    void fromFileData(quint16, quint8, QByteArray);



};



#endif // FILEHANDLER_H
