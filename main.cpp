
#include <erhi_main.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    erhi_main er(&engine, &app);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QObject::connect(&engine,SIGNAL(objectCreated(QObject*, const QUrl &)),
                     &er,SLOT(onEngineCreated(QObject*, const QUrl &)),
                     Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
