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


void FileHandler::readDataFromFile(QString(path)){


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


void FileHandler::writeToFile(){
    qDebug() << "entered writetofile";
    QString fileName = QDateTime::currentDateTime().toString();
    QFile file("C:/Users/hkonw/OneDrive/Documents/GitHub/Software2021/PieceOfShift/src/Decoding/test.txt");
    file.seek(0);
    qDebug() << "file opened";
    // file("Logs/fileName.txt") ?

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)){
        qDebug() << "big thing error";
        return;}
    file.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
    QList<QByteArray> test;
    QByteArray en("hei dette er først de fire og så bang");
    QByteArray to("Poopy-di scoop Scoop-diddy-whoop Whoop-di-scoop-di-poop Poop-di-scoopty Scoopty-whoop");

    test.push_back(en);
    test.push_back(to);

    qDebug() << "skal skrive i file";
    QTextStream dataOutputStream(&file);
    qDebug() << "skriver i file";
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



