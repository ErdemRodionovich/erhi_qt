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
            if(j.contains("vibrateOnCircle") && j["vibrateOnCircle"].isBool()){
                proot->setProperty("vibrateOnCircle", j["vibrateOnCircle"].toBool());
            }
            if(j.contains("soundOnTick") && j["soundOnTick"].isBool()){
                proot->setProperty("soundOnTick", j["soundOnTick"].toBool());
            }
            if(j.contains("soundOnCircle") && j["soundOnCircle"].isBool()){
                proot->setProperty("soundOnCircle", j["soundOnCircle"].toBool());
            }
            if(j.contains("soundNumberOnCircle") && j["soundNumberOnCircle"].isDouble()){
                proot->setProperty("soundNumberOnCircle", j["soundNumberOnCircle"].toInt());
            }
            if(j.contains("soundNumberOnTick") && j["soundNumberOnTick"].isDouble()){
                proot->setProperty("soundNumberOnTick", j["soundNumberOnTick"].toInt());
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

    qreal dpi = app->primaryScreen()->physicalDotsPerInch();
    qreal dpcm = dpi/2.54;

    QMetaObject::invokeMethod(proot,
                              "set_dpcm",
                              Qt::QueuedConnection,
                              Q_ARG(QVariant,dpcm));

    qDebug()<<"dpi="<<dpi<<" dpcm="<<dpcm;

}

void erhi_main::saveSettings(){

    QFile f(QStringLiteral("user_settings.json"));
    if(f.open(QIODevice::WriteOnly)){

        QJsonObject j;

        j["ticksPerCircle"]=proot->property("ticksPerCircle").toInt();
        j["circleCount"]=proot->property("circleCount").toInt();
        j["vibrateOnTick"]=proot->property("vibrateOnTick").toBool();
        j["soundOnTick"]=proot->property("soundOnTick").toBool();
        j["vibrateOnCircle"]=proot->property("vibrateOnCircle").toBool();
        j["soundOnCircle"]=proot->property("soundOnCircle").toBool();
        j["soundNumberOnTick"]=proot->property("soundNumberOnTick").toInt();
        j["soundNumberOnCircle"]=proot->property("soundNumberOnCircle").toInt();
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
            QMetaObject::invokeMethod(proot,
                                      "updateTexts",
                                      Qt::QueuedConnection);
            qDebug()<<"install translator successfully!";

        }else {
            qDebug()<<"NOT install translator!!!";
        }

    }

    qDebug()<<"setLanguage end";

}
