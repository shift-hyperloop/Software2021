#ifndef CONNECTION_H
#define CONNECTION_H

#include <QCanBus>
#include <QCanBusDevice>

class connection
{
public:
    typedef QPair<QCanBusDevice::ConfigurationKey, QVariant> ConfigurationItem;

    explicit connection();
};

#endif // CONNECTION_H
