#pragma once

#include <QVector>
#include <QMap>
#include <QPointF>
#include <QVariant>
#include <qvariant.h>
#include <qvector.h>

class PlotData
{
public:

    ~PlotData()
    {
        for (auto list : m_Data.values())
        {
            for (auto pair : *list) {
                delete pair.first;
                delete pair.second;
            }
            delete list;
        }
    }

    void insertEmpty(const QString& key)
    {
        QVector<double>* x = new QVector<double>();
        QVector<QVariant>* y = new QVector<QVariant>();
        QPair<QVector<double>*, QVector<QVariant>*> pair(x, y);
        QList<QPair<QVector<double>*, QVector<QVariant>*>>* list = new QList<QPair<QVector<double>*, QVector<QVariant>*>>;
        list->append(pair);
        m_Data.insert(key, list);
    }

    void addData(const QString& key, int graphNum, double x, double y)
    {
        if (!m_Data.contains(key)) insertEmpty(key);

        if (m_Data.value(key)->size() == graphNum) {
            QVector<double>* xVec = new QVector<double>();
            QVector<QVariant>* yVec = new QVector<QVariant>();
            xVec->append(x);
            yVec->append(y);
            QPair<QVector<double>*, QVector<QVariant>*> pair(xVec, yVec);
            m_Data.value(key)->append(pair);
            return;
        }

        m_Data.value(key)->at(graphNum).first->append(x); // Append x data to graphNum
        m_Data.value(key)->at(graphNum).second->append(y); // Append y data to graphNum
    }

    void addData(const QString& key, int graphNum, const QPointF& point)
    {
        addData(key, graphNum, point.x(), point.y());
    }

    void remove(const QString& key)
    {
        QList<QPair<QVector<double>*, QVector<QVariant>*>>* list = m_Data.value(key);
        for (auto pair : *list)
        {
            delete pair.first;
            delete pair.second;
        }
        m_Data.remove(key);
        delete list;
    }

    QVector<double> getXValues(const QString& key, int graphNum)
    {
        return *m_Data.value(key)->at(graphNum).first;
    }

    QVector<double> getYValues(const QString& key, int graphNum)
    {
        QVector<double> list;
        for (QVariant v : *m_Data.value(key)->at(graphNum).second) {
            list.append(v.value<double>());
        }
        return list;
    }

    bool hasKey(const QString& key)
    {
        return m_Data.contains(key);
    }

    inline QList<QString> getDataTypes() { return m_Data.keys(); }

private:
    QMap<QString, QList<QPair<QVector<double>*, QVector<QVariant>*>>*> m_Data;
};