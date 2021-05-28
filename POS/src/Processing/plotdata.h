#pragma once

#include <QMap>
#include <QPointF>
#include <QVariant>
#include <QVector>
#include <qdebug.h>
#include <qvariant.h>
#include <qvector.h>

/*
 * This class is a wrapper around a QMap<QString, QPair<QVector<double>*, QVector<QVariant>*>>
 * to make life easier.
 */

class PlotData
{
public:
    ~PlotData()
    {
        for (auto pair : m_Data.values()) {
            delete pair.first;
            delete pair.second;
        }
    }

    void insertEmpty(const QString &key)
    {
        QVector<double> *x = new QVector<double>();
        QVector<QVariant> *y = new QVector<QVariant>();
        QPair<QVector<double> *, QVector<QVariant> *> pair(x, y);
        m_Data.insert(key, pair);
    }

    void addData(const QString &key, double x, QVariant y)
    {
        if (!m_Data.contains(key))
            insertEmpty(key);

        m_Data.value(key).first->append(x);
        m_Data.value(key).second->append(y);
    }

    void addData(const QString &key, const QPointF &point) { addData(key, point.x(), point.y()); }

    void remove(const QString &key)
    {
        QPair<QVector<double> *, QVector<QVariant> *> pair = m_Data.value(key);
        delete pair.first;
        delete pair.second;
        m_Data.remove(key);
    }

    inline QList<QString> names() const { return m_Data.keys(); }

    QVector<double> getXValues(const QString &key) const { return *m_Data.value(key).first; }

    QVector<double> getYDoubleValues(const QString &key) const
    {
        QVector<double> list;
        auto x = m_Data.value(key);
        qDebug() << x.second->size();
        for (QVariant v : *m_Data.value(key).second) {
            list.append(v.value<double>());
        }
        return list;
    }

    QVector<QVariant> getYValues(const QString &key) const
    {
        QVector<QVariant> list;
        for (QVariant v : *m_Data.value(key).second) {
            list.append(v);
        }
        return list;
    }

    bool hasKey(const QString &key) { return m_Data.contains(key); }
    QMap<QString, QPair<QVector<double> *, QVector<QVariant> *>> dataMap() const { return m_Data; }

private:
    QMap<QString, QPair<QVector<double> *, QVector<QVariant> *>> m_Data;
};
