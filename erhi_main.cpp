#include "erhi_main.h"

erhi_main::erhi_main(QQmlApplicationEngine *eng,
                     QGuiApplication *ap,
                     QObject *parent) : QObject(parent)
{

    engine = eng;
    app = ap;

}

void erhi_main::onEngineCreated(QObject *obj, const QUrl &objUrl){

    if (!obj){
        qDebug()<<" Window is NULL! ";
        QCoreApplication::exit(-1);
        return;
    }

    proot = obj;

    QObject::connect(proot,SIGNAL(vibrate(qint32)),
                     this,SLOT(vibrate(qint32)),
                     Qt::QueuedConnection);

    QObject::connect(proot,SIGNAL(closing(QQuickCloseEvent*)),
                     this,SLOT(closing(QQuickCloseEvent*)),
                     Qt::QueuedConnection);

    loadSettings();

}

void erhi_main::vibrate(qint32 duration){

    native_utils::vibrate(duration);

}

void erhi_main::loadSettings(){

    QFile f(QStringLiteral("user_settings.json"));
    if(f.exists()){
        if(f.open(QIODevice::ReadOnly)){

            QByteArray data = f.readAll();
            f.close();
            QJsonDocument sdoc(QJsonDocument::fromJson(data));
            QJsonObject j = sdoc.object();

            if(j.contains("circleCount") && j["circleCount"].isDouble()){
                proot->setProperty("circleCount", j["circleCount"].toInt());
            }
            if(j.contains("ticksPerCircle") && j["ticksPerCircle"].isDouble()){
                proot->setProperty("ticksPerCircle", j["ticksPerCircle"].toInt());
            }
            if(j.contains("vibrateOnTick") && j["vibrateOnTick"].isBool()){
                proot->setProperty("vibrateOnTick", j["vibrateOnTick"].toBool());
            }

            qDebug()<<"settings loaded";

        }
    }

}

void erhi_main::saveSettings(){

    QFile f(QStringLiteral("user_settings.json"));
    if(f.open(QIODevice::WriteOnly)){

        QJsonObject j;

        j["ticksPerCircle"]=proot->property("ticksPerCircle").toInt();
        j["circleCount"]=proot->property("circleCount").toInt();
        j["vibrateOnTick"]=proot->property("vibrateOnTick").toBool();

        QJsonDocument sdoc(j);
        f.write(sdoc.toJson());
        f.close();

        qDebug()<<"settings saved";

    }else{
        qDebug()<<"cannot save settings! cannot write file!";
    }

}

void erhi_main::closing(QQuickCloseEvent *closeEvent){

    saveSettings();
    qDebug()<<"close !";

}
