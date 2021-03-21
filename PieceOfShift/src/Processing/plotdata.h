#pragma once

#include <QVector>
#include <QMap>
#include <QPointF>

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
        QVector<double>* y = new QVector<double>();
        QPair<QVector<double>*, QVector<double>*> pair(x, y);
        QList<QPair<QVector<double>*, QVector<double>*>>* list = new QList<QPair<QVector<double>*, QVector<double>*>>;
        list->append(pair);
        m_Data.insert(key, list);
    }

    void addData(const QString& key, int graphNum, double x, double y)
    {
        if (!m_Data.contains(key)) insertEmpty(key);

        if (m_Data.value(key)->size() == graphNum) {
            QVector<double>* xVec = new QVector<double>();
            QVector<double>* yVec = new QVector<double>();
            xVec->append(x);
            yVec->append(y);
            QPair<QVector<double>*, QVector<double>*> pair(xVec, yVec);
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
        QList<QPair<QVector<double>*, QVector<double>*>>* list = m_Data.value(key);
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
        return *m_Data.value(key)->at(graphNum).second;
    }

    bool hasKey(const QString& key)
    {
        return m_Data.contains(key);
    }

private:
    QMap<QString, QList<QPair<QVector<double>*, QVector<double>*>>*> m_Data;
};