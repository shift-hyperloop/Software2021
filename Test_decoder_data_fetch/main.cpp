#include <QCoreApplication>
#include "canframes.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    canframes w;
    w.busStatus();


    return a.exec();
}
