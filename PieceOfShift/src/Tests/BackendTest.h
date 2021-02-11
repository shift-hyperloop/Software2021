#include <QObject>
#include "Processing/datamanager.h"

class BackendTest : public QObject
{
    Q_OBJECT

private slots:

    void initTestCase()
    {
    }


private:
    DataManager dataManager;

};
