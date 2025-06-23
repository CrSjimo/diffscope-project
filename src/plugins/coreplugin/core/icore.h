#ifndef DIFFSCOPE_COREPLUGIN_ICORE_H
#define DIFFSCOPE_COREPLUGIN_ICORE_H

#include <QObject>
#include <QSettings>

#include <CoreApi/icorebase.h>

#include <coreplugin/coreglobal.h>

namespace Core {

    namespace Internal {
        class CorePlugin;
    }

    class ICorePrivate;

    class CORE_EXPORT ICore : public ICoreBase {
        Q_OBJECT
        Q_DECLARE_PRIVATE(ICore)
    public:
        static ICore *instance();

        static int showSettingsDialog(const QString &id, QWidget *parent);
        static void showPluginsDialog(QWidget *parent);
        static void showHome();

    public:
        void newFile() const;
        bool openFile(const QString &fileName, QWidget *parent = nullptr) const;

    private:
        explicit ICore(QObject *parent = nullptr);
        ~ICore();

        ICore(ICorePrivate &d, QObject *parent = nullptr);

        friend class Internal::CorePlugin;
    };

}

#endif // DIFFSCOPE_COREPLUGIN_ICORE_H