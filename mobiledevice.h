#ifndef MOBILEDEVICE_H
#define MOBILEDEVICE_H

#include <QObject>


class MobileDevice: public QObject
{

    Q_OBJECT

    const char *javaClassPath;

public:
    MobileDevice();

    Q_INVOKABLE void openSettings();
    Q_INVOKABLE void openLocationSettings();
    Q_INVOKABLE void openUrl(QString fullUrl);


    Q_INVOKABLE QStringList locationProviders();
    Q_INVOKABLE QStringList primaryStorageStatus();
    Q_INVOKABLE QString primaryStoragePath();
    Q_INVOKABLE QString primaryPrivateStoragePath();
    Q_INVOKABLE QString createDirectory();



};

#endif // MOBILEDEVICE_H
