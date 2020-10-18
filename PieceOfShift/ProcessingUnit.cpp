#include "ProcessingUnit.h"

void ProcessingUnit::process()
{
    if(!isRunning()) {
        start(priority);
    } else {
        restart = true;
        waitCondition.wakeOne();
    }
}
