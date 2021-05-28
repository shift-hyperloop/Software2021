#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include "Processing/datastructs.h"
#include "Processing/plotdata.h"
#include "src/Decoding/canserver.h"
#include "src/Decoding/decoder.h"
#include "src/Decoding/filehandler.h"
#include <QObject>
#include <QVector>
#include <QtConcurrent/QtConcurrent>
#include <qlist.h>
#include <qvariant.h>

class CustomPlotItem;

class CustomPlotItem;

class DataManager : public QObject
{
    Q_OBJECT

public:
    DataManager();
    ~DataManager();

public slots:

    void dummyData();

    void init();

    // Decoder uses this slot on new data recieved
    void addData(unsigned int timeMs,
                 const QString &name,
                 const DataType &dataType,
                 QByteArray data);

    // Slot connected to CANServer to establish TCP connection with pod
    void connectToPod(QString hostname, QString port);

    // Sends PodCommand to pod which is a CAN message ID
    void sendPodCommand(CANServer::PodCommand command);

    // Register new graph, called by QML when creating CustomPlotItems.
    // This so that when data is recieved it can be added to the plot without going through QML
    void registerGraph(CustomPlotItem *plotItem, const QString &name, int graphIndex);

    // Remove plot, called by QML when CustomPlotItems are deleted so that data is not added to non-existing plots
    void removePlot(CustomPlotItem *plotItem);

    inline QList<QString> getAllDataNames() { return plotData->names(); }

    // Write current data to log file
    void writeLogFile(QString path);

    // Read log file and send through pipeline
    void readLogFile(QString path);

signals:
    // Signals to QML that state has change in some way to update interface

    void podConnectionEstablished();
    void podConnectionTerminated();

    void newData(const QString &name, unsigned int timeMs, const QVariantList &data);

private:
    // Internal function used for adding data to plot
    void addPlotData(const QString &name, unsigned int timeMs, QVariant data);

    // Map of data names to graphs that are displaying that data
    QMap<QString, QList<QPair<CustomPlotItem *, int>> *> plotItems;

    // All plot data, wrapper class
    std::unique_ptr<PlotData> plotData;

    // Other backend classes
    Decoder decoder;
    CANServer canServer;
    FileHandler fileHandler;
};

// The purpose of this class is to have a single DataManager object which can be accessed from QML using this class.
// This because objects cannot be shared between QML files in a nice manner so this method let's all QML files
// access the same DataManager object by using DataManagerAccessor.
class DataManagerAccessor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DataManager *dataManager READ dataManager)

private:
    static DataManager *_obj; // Initialized in .cpp

public:
    DataManagerAccessor(QObject *parent = 0)
        : QObject(parent)
    {}
    DataManager *dataManager() { return _obj; }
    static void setDataManager(DataManager *manager) { _obj = manager; }
};

#endif // DATAMANAGER_H
