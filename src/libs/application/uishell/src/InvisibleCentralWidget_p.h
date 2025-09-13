#ifndef DIFFSCOPE_UISHELL_INVISIBLECENTRALWIDGET_P_H
#define DIFFSCOPE_UISHELL_INVISIBLECENTRALWIDGET_P_H

#include <QWidget>
#include <QWindow>
#include <qqmlintegration.h>

namespace UIShell {

    class InvisibleCentralWidget : public QWidget {
        Q_OBJECT
        QML_ELEMENT
        Q_PROPERTY(QWindow *windowHandle READ windowHandle CONSTANT)
    public:
        explicit InvisibleCentralWidget(QWidget *parent = nullptr);
        ~InvisibleCentralWidget() override;
    };

}

#endif //DIFFSCOPE_UISHELL_INVISIBLECENTRALWIDGET_P_H
