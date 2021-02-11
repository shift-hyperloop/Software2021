#include "filehandler.h"
#include "cansplitter.h"

#include <QDebug>
#include <QDateTime>
#include <QRegExp>
#include <QFile>
#include <QTextStream>


FileHandler::FileHandler() {

}

FileHandler::~FileHandler(){

}




void FileHandler::readDataFromFile(QString(path)){
    QFile file(path);
    qDebug() << "reading from file";



    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        return;
    }

    QTextStream in(&file);
    while (!in.atEnd()){
        QString line = in.readLine();
        bool ok;






        // Reading from file, splitting the comma seperation
        QStringList stringList = line.split(QRegExp("\\,"));

        // ushort u = stringList[0].toUShort(&ok, 10);
        // stringList[0].toUShort(&ok, 10);

        QByteArray b = stringList[1].toLocal8Bit();
        // QByteArray b2 = stringList[2].to



        // Sending data for further processing
        // emit fromFileData(stringList[0].toUShort(&ok, 10), b[0], );



        // loop processing unit, store in dataMap
           // newData(q[0], q[1], q[2]);
        }
}


void FileHandler::writeToFile(){
    QString fileName = QDateTime::currentDateTime().toString();
    /*
    QString path = "C:/Users/simon/OneDrive/Dokumenter/GitHub"
                   "/Software2021/PieceOfShift/src/Decoding/test123.txt";
                   */
    QFile file(fileName);



   // file.close();
    file.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
    file.seek(0);


/*  This statement prints out that file is not open
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)){
        qDebug() << "nope not opening";
        qDebug() << file.errorString();
    }
    */


    // Dummy data
    QList<QByteArray> test;

    QByteArray en("hei dette er først de fire og så bang");
    QByteArray to("Poopy-di scoop Scoop-diddy-whoop Whoop-di-scoop-di-poop Poop-di-scoopty Scoopty-whoop");
    test.push_back(en);
    test.push_back(to);


    QTextStream dataOutputStream(&file);

    // splitting up messages, seperating contents for storing purposes
    for (QByteArray qByteArray : test){
        dataOutputStream << qByteArray.mid(0, 2) + "," + qByteArray.mid(8,1) + "," +
                            qByteArray.mid(12, 1) + "\n";
    }

        // qFromBigEndian<quint16>(datagram.mid(CAN_ID_OFFSET, CAN_ID_SIZE).toHex().toInt(&ok, 16));


    file.flush();
    file.close();
    // qDebug() << "File has been written with path: ";
}



