#include "erhi_main.h"

erhi_main::erhi_main(QObject *parent) : QObject(parent)
{

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

}

void erhi_main::vibrate(qint32 duration){

    native_utils::vibrate(duration);

}
