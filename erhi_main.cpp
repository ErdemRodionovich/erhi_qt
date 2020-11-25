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

    QObject::connect(proot,SIGNAL(setLanguage(QString)),
                     this,SLOT(setLanguage(QString)),
                     Qt::QueuedConnection);

    QObject::connect(proot,SIGNAL(setLanguage(QString)),
                     this,SLOT(setLanguage(QString)),
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
            if(j.contains("lang") && j["lang"].isString()){

                QString l = j["lang"].toString();
                proot->setProperty("lang", l);

                setLanguage(l);

            }

            qDebug()<<"settings loaded";

        }
    }else{

        setLanguage(QLocale::system().name());

    }

}

void erhi_main::saveSettings(){

    QFile f(QStringLiteral("user_settings.json"));
    if(f.open(QIODevice::WriteOnly)){

        QJsonObject j;

        j["ticksPerCircle"]=proot->property("ticksPerCircle").toInt();
        j["circleCount"]=proot->property("circleCount").toInt();
        j["vibrateOnTick"]=proot->property("vibrateOnTick").toBool();
        j["lang"]=proot->property("lang").toString();

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

void erhi_main::setLanguage(QString lang){

    QTranslator translator;
    bool fileOfTranslationLoaded = false;
    if (lang == "ru") {
        fileOfTranslationLoaded = translator.load(":/i18n/erhi_ru_RU.qm");
    }else if (lang == "bua") {
        fileOfTranslationLoaded = translator.load(":/i18n/erhi_bua_BUA.qm");
    }else {
        fileOfTranslationLoaded = translator.load(":/i18n/erhi_en_UK.qm");
    }

    if(!fileOfTranslationLoaded){
        qDebug()<<"file of translation NOT loaded!";
    }else{

        if(app->installTranslator(&translator)){

            engine->retranslate();
            qDebug()<<"install translator successfully!";

        }else {
            qDebug()<<"NOT install translator!!!";
        }

    }

//    QVariant rV;
//    QMetaObject::invokeMethod(proot,
//                              "updateTexts",
//                              Qt::QueuedConnection);

    qDebug()<<"setLanguage end";

}

//bool erhi_main::event(QEvent *pe){

//    if(pe->type() == QEvent::LanguageChange){

//        QMetaObject::invokeMethod(proot,
//                                  "updateTexts",
//                                  Qt::QueuedConnection);
//        qDebug()<<"update texts from event!";

//        return true;

//    }

//    return QWidget::event(pe);

//}
