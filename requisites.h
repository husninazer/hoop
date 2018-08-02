#ifndef REQUISITES_H
#define REQUISITES_H

#include <QObject>

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QFile>
#include <QFileInfo>
#include <QDir>

#include <QSharedMemory>
#include <QUrl>

#include <QtQml>

//extern QString offlineStoragePath;
extern QQmlApplicationEngine *_engine;

#include <QNetworkInterface>
#include <QCryptographicHash>

#include <qdebug.h>


extern bool _jsonToexcel(QJsonArray data, QJsonObject colWidthList, QString fileName);

class Requisites : public QObject{
   Q_OBJECT


    QString _exeLocation;
public:
    void setExeLocation(QString location)
    {
        _exeLocation = location;
    }
    Q_INVOKABLE QString exeLocation()
    {
        QDir dir;
        dir.cdUp();
        return dir.absolutePath();
        return _exeLocation;
    }


    Q_INVOKABLE QString currentLocation()
    {
        QDir dir;
        return dir.absolutePath();
        return _exeLocation;
    }


//    Q_INVOKABLE bool jsonToexcel(QJsonArray data, QJsonObject colWidthList, QString fileName) {
//        return _jsonToexcel(data, colWidthList, fileName);
//    }

    QString shared_memory_status;

    explicit Requisites (QObject* parent = 0) : QObject(parent) { }



    Q_INVOKABLE int saveStringToFile(QString str, QString url)
    {
        QFile file(url);
        if (!file.open(QFile::ReadWrite))
            return -1;

        int res = file.write(str.toLocal8Bit());

        file.close();
        return res;
    }

    Q_INVOKABLE QString currentCpuArchitecture()
    {
//        "arm"
//        "arm64"
//        "i386"
//        "ia64"
//        "mips"
//        "mips64"
//        "power"
//        "power64"
//        "sparc"
//        "sparcv9"
//        "x86_64"
        return QSysInfo::currentCpuArchitecture();
    }


    Q_INVOKABLE int saveBase64StringToBinaryFile(QString str, QString url)
    {
        QFile file(url);

        if (!file.open(QFile::ReadWrite)) {
            qDebug() << file.errorString();
            return -2;
        }


        QByteArray byteArray; byteArray = byteArray.fromBase64(str.toLocal8Bit());
        int res = file.write(byteArray);

        file.close();
        return res;
    }


    Q_INVOKABLE bool createDirectory(QString url)
    {
        QDir dir;
        bool status =  dir.mkdir(url);

        return status;
    }



    Q_INVOKABLE QString sharedMemoryStatus()
    {
        return shared_memory_status;
    }

    Q_INVOKABLE void settingsSet(QString key, QString value)
    {
        QSettings settings("settings.ini");
        settings.setValue(key, value);
    }

    Q_INVOKABLE QString settingsGet(QString key)
    {
        QSettings settings("settings.ini");
        return settings.value(key).toString();
    }


    Q_INVOKABLE QString getMacAddressToRegister()
    {
        foreach(QNetworkInterface interface, QNetworkInterface::allInterfaces())
        {
            // Return only the first non-loopback MAC Address
            if (!(interface.flags() & QNetworkInterface::IsLoopBack))
                return interface.hardwareAddress();
        }
        return QString();
    }

    Q_INVOKABLE QVariantList getMacAddressList()
    {
        QVariantList list;
        foreach(QNetworkInterface interface, QNetworkInterface::allInterfaces())
        {
            list << interface.hardwareAddress();
        }
        return list;
    }

    // For converting the urls that are recieved by FileDialog components. For direct path, no need to use this.
    Q_INVOKABLE QString urlToFile(QString urlString)
    {
        QUrl url(urlString);
        return url.toLocalFile();
    }

    Q_INVOKABLE bool isFileExists(QString filename)
    {
        QFile file;
        QUrl url(filename);
        return file.exists(url.toLocalFile());
    }

    Q_INVOKABLE bool isDirExists(QString dirString)
    {
        QDir dir(dirString);
        return dir.exists();
    }

    Q_INVOKABLE QString fileToString(QString filename)
    {
        QFile file(filename);
        if (!file.open(QFile::ReadOnly))
            return "Error";

        return file.readAll();
    }

    Q_INVOKABLE QString standardPath()
    {

        QString mDataPath = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation).value(0);

        createDirectory(mDataPath);

        return mDataPath;
    }


    Q_INVOKABLE void printHtmlToPdf(QString html, int printCopies, QString url)
    {



    }

    Q_INVOKABLE QString fileToBase64String(QString filename)
    {
        QFile file(filename);
        if (!file.open(QFile::ReadOnly))
            return "Error";

        QByteArray fileData;
        fileData = file.readAll();

        QString encoded;
        encoded = fileData.toBase64();

        // qDebug () << "Byte Array Size " << fileData.size() / 1024;
        // qDebug () << "Encoded Size "  << encoded.size()/ 1024;
        // qDebug() << "Compressed " << qCompress(encoded.toLocal8Bit()).size()/ 1024;

        return encoded;
    }

    Q_INVOKABLE QString md5sumFile(QString filename)
    {
        QFile file(filename);
        if(file.open(QIODevice::ReadOnly))
        {
            QString hash = QCryptographicHash::hash(file.readAll(), QCryptographicHash::Md5).toHex().constData();
            file.close();
            return hash;
        }

        return "";
    }

//    Q_INVOKABLE bool isOnline()
//    {

//    }

//    Q_INVOKABLE QString getLocalStoragePathToDatabase()
//    {
//        return offlineStoragePath;
//    }


    Q_INVOKABLE bool renameFile(QString oldFilename, QString newFilename)
    {
        QFile file;
        return file.rename(oldFilename, newFilename);
    }

    Q_INVOKABLE bool copyFile(QString from, QString to)
    {
        QFile file;
        return file.copy(from, to);
    }

    Q_INVOKABLE bool deleteFile(QString filename)
    {
        QFile file;
        return file.remove(filename);
    }

//    Q_INVOKABLE QString getDbPath(QString dbName) // Local Storage name eg: Offline
//    {

////        QString path = offlineStoragePath + "/Databases/";

//        QString dbPath;
//        QDir myDir(path);
//        QStringList list;
//        list = myDir.entryList();
//        bool endLoop = false;

//        for(int i = 0; i < list.size() && !endLoop; i++)
//        {
//            QFileInfo file = path + list.at(i);
//            if(file.fileName().endsWith(".ini"))
//            {
//                QFile ini(file.absoluteFilePath());
//                if (!ini.open(QIODevice::ReadOnly | QIODevice::Text))
//                    continue;

//                while(!ini.atEnd())
//                {
//                    QString line = ini.readLine();
//                    if(line.contains(dbName)) //probably could be better
//                    {
//                        dbPath= file.absoluteFilePath().replace(".ini", ".sqlite");
//                        endLoop = true;
//                    }
//                }

//                ini.close();
//            }
//        }
//        return dbPath;
//    }


    Q_INVOKABLE void doDownload(QString url)
    {
        connect(&manager, SIGNAL(finished(QNetworkReply*)),
                this, SLOT(replyFinished(QNetworkReply*)));

        manager.get(QNetworkRequest(QUrl(url)));

    }


    Q_INVOKABLE void doImageDownload(QString url)// For downloading image and sending data to qml
    {
        manager.get(QNetworkRequest(QUrl(url)));
    }

    Q_INVOKABLE void setFunc(QJSValue f)// For downloading image and sending data to qml
    {
        connect(&manager, SIGNAL(finished(QNetworkReply*)),
                this, SLOT(replyImageFinished(QNetworkReply*)));
        func = f;
    }


    QJSValue func;// For downloading image and sending data to qml


signals:

    void downloadError(QString error);
    void downloadSuccessful(QString ContentTypeHeader, QString LastModifiedHeader, QString ContentLengthHeader, QString HttpStatusCodeAttribute, QString HttpReasonPhraseAttribute);


public slots:
    void replyFinished (QNetworkReply *reply)
    {
        if(reply->error())
        {
            emit downloadError(reply->errorString());
        }
        else
        {
            emit downloadSuccessful(
                        reply->header(QNetworkRequest::ContentTypeHeader).toString(),
                        reply->header(QNetworkRequest::LastModifiedHeader).toDateTime().toString(),
                        reply->header(QNetworkRequest::ContentLengthHeader).toString(),
                        reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toString(),
                        reply->attribute(QNetworkRequest::HttpReasonPhraseAttribute).toString()
                        );

            if (reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() == 200) { // If success, then save
                QFile *file = new QFile("qml.rcc");
                file->remove();

                if(file->open(QFile::Append))
                {
                    file->write(reply->readAll());
                    file->flush();
                    file->close();
                }
                delete file;
            }
        }

        reply->deleteLater();
    }




    void replyImageFinished (QNetworkReply *reply) // For downloading image and sending data to qml
    {
        if(reply->error())
        {
            emit downloadError(reply->errorString());
        }
        else
        {
            if (reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt() == 200) { // If success, then save
                QByteArray a = reply->readAll();
                QString en = a.toBase64();
                func.call(QJSValueList() << en);

            }
        }

        reply->deleteLater();
    }


private:
   QNetworkAccessManager manager;
};

#endif // REQUISITES_H
