#include "mobiledevice.h"
#include <QtQml>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#endif

MobileDevice *mobileDevice;

MobileDevice::MobileDevice()
{
    javaClassPath = "org/qereb/AndroidRequisites";
    mobileDevice = this;

}

void MobileDevice::openSettings()
{
#ifdef Q_OS_ANDROID
    QAndroidJniObject::callStaticMethod<void>(javaClassPath,
                                                  "openSettings",
                                                  "()V");
#endif
}


void MobileDevice::openLocationSettings()
{

#ifdef Q_OS_ANDROID

    QAndroidJniObject::callStaticMethod<void>(javaClassPath,
                                              "openLocationSettings",
                                              "()V");
#endif

}

void MobileDevice::openUrl(QString fullUrl) // ("file:///sdcard/ticket.pdf")
{
#ifdef Q_OS_ANDROID
    QStringList strList = fullUrl.split(".");
    QString extension = strList.count() ? strList.at(strList.count() - 1) : "";

    QAndroidJniObject::callStaticMethod<void>(javaClassPath,
                                              "openUrl",
                                              "(Ljava/lang/String;Ljava/lang/String;)V", QAndroidJniObject::fromString(fullUrl).object<jstring>(),  QAndroidJniObject::fromString(extension).object<jstring>());
#endif
}

QStringList MobileDevice::locationProviders()
{
    QList<QString> providers;
#ifdef Q_OS_ANDROID
    QAndroidJniObject status = QAndroidJniObject::callStaticObjectMethod<jstring>(javaClassPath, "locationProviders");       // Use callStaticObjectMethod rather than callStaticMethod for methods returning complex types like jstring, object, etc. Simple types include int, void, etc.
    if (status.toString().contains("GPS"))
        providers.append("GPS");
    if (status.toString().contains("NETWORK"))
        providers.append("NETWORK");
#endif
    return providers;
}

QStringList MobileDevice::primaryStorageStatus()
{
    QList<QString> providers;
#ifdef Q_OS_ANDROID
    QAndroidJniObject status = QAndroidJniObject::callStaticObjectMethod<jstring>(javaClassPath, "primaryStorageStatus");
    if (status.toString().contains("READ"))
        providers.append("READ");
    if (status.toString().contains("WRITE"))
        providers.append("WRITE");
#endif
    return providers;
}




QString MobileDevice::primaryStoragePath() // does not have the ending slash
{
    QString path;
#ifdef Q_OS_ANDROID
    QAndroidJniObject status = QAndroidJniObject::callStaticObjectMethod<jstring>(javaClassPath, "primaryStoragePath");
    path = status.toString();
#endif
    return path;
}

QString MobileDevice::createDirectory() // does not have the ending slash
{
    QString path;
#ifdef Q_OS_ANDROID
    QAndroidJniObject status = QAndroidJniObject::callStaticObjectMethod<jstring>(javaClassPath, "createDirectory");
    path = status.toString();
#endif
    return path;
}

QString MobileDevice::primaryPrivateStoragePath() // does not have the ending slash
{
    QString path;
#ifdef Q_OS_ANDROID
    QAndroidJniObject status = QAndroidJniObject::callStaticObjectMethod<jstring>(javaClassPath, "primaryPrivateStoragePath");
    path = status.toString();
#endif
    return path;
}

void registerMobileDeviceTypes() {
    qmlRegisterType<QObject>();
    qmlRegisterType<MobileDevice>("MobileDevice", 0, 1, "MobileDevice");
}

Q_COREAPP_STARTUP_FUNCTION(registerMobileDeviceTypes)
