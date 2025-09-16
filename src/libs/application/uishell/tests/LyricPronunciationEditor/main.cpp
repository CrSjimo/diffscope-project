#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QSurfaceFormat>
#include <QQuickStyle>
#include <QStandardItemModel>

#include <uishell/USDef.h>

using namespace UIShell;

int main(int argc, char *argv[]) {
    QGuiApplication a(argc, argv);

    auto sf = QSurfaceFormat::defaultFormat();
    sf.setSamples(8);
    QSurfaceFormat::setDefaultFormat(sf);

    QQuickStyle::setStyle("SVSCraft.UIComponents");
    QQuickStyle::setFallbackStyle("Basic");

    QList<QList<QVariantList>> lyrics {
        {
            {"jiao", "�?, QStringList{"jiao"}},
            {"zhi", "�?, QStringList{"zhi"}},
            {"de", "�?, QStringList{"de", "di"}},
            {"luo", "�?, QStringList{"luo"}},
            {"xuan", "�?, QStringList{"xuan"}},
            {"xian", "�?, QStringList{"xian"}},
            {"jiao", "�?, QStringList{"jiao"}},
            {"zhi", "�?, QStringList{"zhi"}},
            {"zhe", "着", QStringList{"zhe", "zhuo", "zhao"}},
            {"pan", "�?, QStringList{"pan"}},
            {"xuan", "�?, QStringList{"xuan"}},
        },
        {
            {"xu", "�?, QStringList{"xu"}},
            {"shu", "�?, QStringList{"shu"}},
            {"zhe", "着", QStringList{"zhe", "zhuo", "zhao"}},
            {"ni", "�?, QStringList{"ni"}},
            {"wo", "�?, QStringList{"wo"}},
            {"de", "�?, QStringList{"de", "di"}},
            {"cong", "�?, QStringList{"cong"}},
            {"qian", "�?, QStringList{"qian"}},
        },
        {
            {"cong", "�?, QStringList{"cong"}},
            {"qian", "�?, QStringList{"qian"}},
            {"you", "�?, QStringList{"you"}},
            {"tai", "�?, QStringList{"tai"}},
            {"duo", "�?, QStringList{"duo"}},
            {"you", "�?, QStringList{"you"}},
            {"tai", "�?, QStringList{"tai"}},
            {"duo", "�?, QStringList{"duo"}},
            {"gu", "�?, QStringList{"gu"}},
            {"shi", "�?, QStringList{"shi"}},
        },
        {
            {"ta", "�?, QStringList{"ta"}},
            {"men", "�?, QStringList{"men"}},
            {"ni", "�?, QStringList{"ni"}},
            {"hai", "�?, QStringList{"hai", "huan"}},
            {"ji", "�?, QStringList{"ji"}},
            {"de", "�?, QStringList{"de", "dei"}},
            {"ma", "�?, QStringList{"ma"}},
        }
    };

    auto model = new QStandardItemModel(lyrics.size(), 1, &a);
    for (int i = 0; i < lyrics.size(); i++) {
        auto item = new QStandardItem;
        for (int j = 0; j < lyrics.at(i).size(); j++) {
            auto rowItem = new QStandardItem;
            rowItem->setData(QVariant::fromValue(lyrics[i][j][0]), USDef::LC_PronunciationRole);
            rowItem->setData(QVariant::fromValue(lyrics[i][j][1]), USDef::LC_LyricRole);
            rowItem->setData(QVariant::fromValue(lyrics[i][j][2]), USDef::LC_CandidatePronunciationsRole);
            item->appendRow(rowItem);
        }
        model->setItem(i, 0, item);
    }

    QQmlApplicationEngine engine;
    engine.setInitialProperties({
        {"model", QVariant::fromValue(model)},
    });
    engine.load(":/qt/qml/DiffScope/UIShell/Test/LyricPronunciationEditor/main.qml");

    return a.exec();
}
