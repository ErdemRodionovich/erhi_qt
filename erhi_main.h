#ifndef ERHI_MAIN_H
#define ERHI_MAIN_H

#include <QObject>
#include <QDebug>
#include <QGuiApplication>
#include "../native_utils/native_utils.h"

class erhi_main : public QObject
{
    Q_OBJECT


private:

    QObject* proot;

public:
    explicit erhi_main(QObject *parent = nullptr);

signals:


public slots:
    void onEngineCreated(QObject *obj, const QUrl &objUrl);
    void vibrate(qint32 duration);

};

#endif // ERHI_MAIN_H
