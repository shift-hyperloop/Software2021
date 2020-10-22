#ifndef VELOCITYPROCESSINGUNIT_H
#define VELOCITYPROCESSINGUNIT_H

#include <QMetaType>
#include "processingunit.h"

typedef struct velocityStruct {
    double velocity;
} VelocityStruct;

// TODO: Move to other file
Q_DECLARE_METATYPE(VelocityStruct);

class VelocityProcessingUnit : public ProcessingUnit
{
    Q_PROPERTY(QVariant data WRITE addData NOTIFY newData)
    QML_ELEMENT
public:
    VelocityProcessingUnit();
    ~VelocityProcessingUnit();

    virtual void run() override;

public slots:
    void addData(VelocityStruct &data);

signals:
    void newData(const QVariant &data);
};

#endif // VELOCITYPROCESSINGUNIT_H




