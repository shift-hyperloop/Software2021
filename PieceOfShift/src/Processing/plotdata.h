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
        for (auto pair : m_Data.values())
        {
            delete pair.first;
            delete pair.second;
        }
    }

    void insertEmpty(const QString& key)
    {
        QVector<double>* x = new QVector<double>();
        QVector<QVariant>* y = new QVector<QVariant>();
        QPair<QVector<double>*, QVector<QVariant>*> pair(x, y);
        m_Data.insert(key, pair);
    }

    void addData(const QString& key, double x, QVariant y)
    {
        if (!m_Data.contains(key)) insertEmpty(key);

        m_Data.value(key).first->append(x);
        m_Data.value(key).second->append(y);
    }

    void addData(const QString& key, const QPointF& point)
    {
        addData(key, point.x(), point.y());
    }

    void remove(const QString& key)
    {
        QPair<QVector<double>*, QVector<QVariant>*> pair = m_Data.value(key);
        delete pair.first;
        delete pair.second;
        m_Data.remove(key);
    }

    QVector<double> getXValues(const QString& key)
    {
        return *m_Data.value(key).first;
    }

    QVector<double> getYValues(const QString& key)
    {
        QVector<double> list;
        for (QVariant v : *m_Data.value(key).second) {
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
    QMap<QString, QPair<QVector<double>*, QVector<QVariant>*>> m_Data;
};