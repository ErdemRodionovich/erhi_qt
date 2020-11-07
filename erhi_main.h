#ifndef ERHI_MAIN_H
#define ERHI_MAIN_H

#include <QObject>
#include <QDebug>
#include <QGuiApplication>
#include "../native_utils/native_utils.h"
#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

class erhi_main : public QObject
{
    Q_OBJECT


private:

    QObject* proot;
    QQmlApplicationEngine *engine;
    QGuiApplication *app;

public:
    explicit erhi_main(QQmlApplicationEngine *eng = nullptr,
                       QGuiApplication *ap = nullptr,
                       QObject *parent = nullptr);

    void loadSettings();
    void saveSettings();

signals:


public slots:
    void onEngineCreated(QObject *obj, const QUrl &objUrl);
    void vibrate(qint32 duration);
    void closing(QQuickCloseEvent *closeEvent);

};

#endif // ERHI_MAIN_H
