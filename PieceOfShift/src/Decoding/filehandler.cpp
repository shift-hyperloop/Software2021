#include "filehandler.h"
// #include "cansplitter.h"

#include <QDebug>
#include <QDateTime>
#include <QRegExp>
#include <QFile>
#include <QTextStream>


FileHandler::FileHandler() {

}

FileHandler::~FileHandler(){

}


void readDataFromFile(QString(path)){


    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        qDebug() << "no i dont think i will";
        return;

        QTextStream in(&file);
        while (!in.atEnd()){
            QString line = in.readLine();
            // "fSep, sSep, tSep"  depends on how we store it all in write fucntion
            // pretend ^ format

            // line.split(QRegExp("\s+"))

            // newData(firstSeperation, secondSeperation, thirdSeperation);
            // send ^forwards to decoder for handling data
        }

    // Recieve file from visualizer/file explorer
    // read from file and stream/ emit to processor

}

// Får inn QbYTEaRRAY
//


void writeToFile(){
    QString fileName = QDateTime::currentDateTime().toString();
    QFile file(fileName);
    // file("Logs/fileName.txt") ?

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return;

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

        // qFromBigEndian<quint16>(datagram.mid(CAN_ID_OFFSET, CAN_ID_SIZE).toHex().toInt(&ok, 16));
        // Might need to do manipulate data s


        // Rememering offsets  in bytearray, where to comma-seperate and stuff
    }

    // dataOutputStream << fetchDataFromDecoder();

    file.flush();
    file.close();
    qDebug() << "File has been written, name/path: ";
}



