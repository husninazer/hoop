#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtCore/QTextStream>
#include <QQuickStyle>
#include <QtQml/qqml.h>

#include <QDebug>



int main(int argc, char *argv[])
{

    const QByteArray additionalLibraryPaths = qgetenv("QTLOCATION_EXTRA_LIBRARY_PATH");
    for (const QByteArray &p : additionalLibraryPaths.split(':'))
        QCoreApplication::addLibraryPath(QString(p));

    QGuiApplication::setApplicationName("Hoop");
    QGuiApplication::setOrganizationName("Hoop");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qDebug() << "productType():" << QSysInfo::productType();

    QString operating_system = QSysInfo::productType();

    if(operating_system == "ios")
        QQuickStyle::setStyle("Universal");

    if(operating_system == "android")
        QQuickStyle::setStyle("Material");

    if(operating_system == "osx")
        QQuickStyle::setStyle("Material");



    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;





    QObject *item = engine.rootObjects().first();
    Q_ASSERT(item);


    return app.exec();
}
