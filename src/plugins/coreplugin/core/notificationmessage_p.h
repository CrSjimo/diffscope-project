#ifndef DIFFSCOPE_COREPLUGIN_NOTIFICATIONMESSAGE_P_H
#define DIFFSCOPE_COREPLUGIN_NOTIFICATIONMESSAGE_P_H

#include <QPointer>

#include <uishell/BubbleNotificationHandle.h>

#include <coreplugin/notificationmessage.h>

namespace UIShell {
    class BubbleNotificationHandle;
}

namespace Core {

    class NotificationMessagePrivate {
        Q_DECLARE_PUBLIC(NotificationMessage)
    public:
        NotificationMessage *q_ptr;
        QPointer<UIShell::BubbleNotificationHandle> handle;
    };

}

#endif //DIFFSCOPE_COREPLUGIN_NOTIFICATIONMESSAGE_P_H
