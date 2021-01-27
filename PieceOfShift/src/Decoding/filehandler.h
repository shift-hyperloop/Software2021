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


private:

    void readDataFromFile();
};



#endif // FILEHANDLER_H
