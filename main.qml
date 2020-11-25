import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import Theme 1.0


Window {
    id:mainWindow
    objectName: "mainWindow"
    width: 640
    height: 480
    visible: true
    title: qsTr("Erhi")

    signal vibrate(int duration)
    signal setLanguage(string language)

    property int curTicks: 0
    property int curCircles: 0
    property int circleCount: 10
    property int ticksPerCircle: 10
    property int soundNumberOnTick: 0
    property bool soundOnTick: true
    property int sounndNumberOnCircle: 0
    property bool soundOnCircle: true
    property bool vibrateOnTick: true
    property bool vibrateOnCircle: true
    property string lang: "en"

    function onTick(){

        curTicks++;
        if(curTicks >= ticksPerCircle){

            curCircles++;
            curTicks=0;

            if(curCircles >= circleCount){

                curCircles=0;

            }

            vibrate(1000);

        }

        curCount_Txt.text = curTicks;
        curCircle_Txt.text = curCircles;

        if (vibrateOnTick){
            vibrate(100);
        }

    }

    function updateTexts(){

        mainWindow.title = qsTr("Erhi");
        ticksPerCircleLabel.text = qsTr("Ticks per circle");
        circleCountLabel.text = qsTr("Circle count");
        vibrateOnTickLabel.text = qsTr("Vibrate on tick");

    }

    Rectangle {
        id: footer
        objectName: "footer"
        x: 0
        y: 0
        width: parent.width
        height: Theme.dpcm*1
        color: Theme.osnFon

        Rectangle {
            id: menu_button
            objectName: "menu_button"
            anchors.left: footer.left
            anchors.top: footer.top
            anchors.bottom: footer.bottom
            width: Theme.dpcm*1.5
            Image{
                source: "tri tochki 1000.png"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
                anchors.margins: Theme.dpcm*0.2
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    menu.visible = true
                    for(var i_index=0;i_index<languageListModel.count;i_index++){

                        if(lang == languageListModel.get(i_index).value){

                            chooseLanguageBox.currentIndex = i_index;
                            break;

                        }

                    }
                }
            }
        }

        Image {
            id: upd_button
            objectName: "upd_button"
            source: "update png 2.png"
            anchors.top: footer.top
            anchors.bottom: footer.bottom
            anchors.right: footer.right
            anchors.margins: 4
            width: Theme.dpcm*1.2
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    curTicks=0;
                    curCircles=0;
                    curCount_Txt.text = curTicks;
                    curCircle_Txt.text = curCircles;
                }
            }
        }

        Rectangle{
            id: curCount
            objectName: "curCount"
            anchors.left: menu_button.right
            anchors.top: footer.top
            anchors.bottom: footer.bottom
            anchors.right: upd_button.left

            Text{
                id:curCount_Txt
                objectName: "curCount_Txt"
                font.pointSize: 20
                font.family: "Arial"
                text: "0"
                anchors.centerIn: curCount
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: curCircle_Txt
                objectName: "curCircle_Txt"
                font.pointSize: 10
                font.family: "Arial"
                text: "0"
                anchors.left: curCount_Txt.right
                anchors.top: curCount_Txt.top
            }

        }

    }

    Image {
        id: osnFon
        objectName: "osnFon"
        x: 0
        y: footer.height
        width: parent.width
        height: parent.height - footer.height
        source: "chetki.jpg"
        clip: false
        fillMode: Image.PreserveAspectFit
        MouseArea{
            anchors.fill: parent
            onClicked: onTick();
        }
    }

    Rectangle{

        id:menu
        objectName: "menu"
        visible: false
        anchors.fill: parent

        MouseArea{
            anchors.fill: parent
        }

        Rectangle{

            id:menuExitButton
            objectName: "menuExitButton"
            anchors.top: parent.top
            anchors.left: parent.left
            //anchors.right: parent.right
            height: Theme.dpcm*1
            width: Theme.dpcm*1.5

            Image {
                id: menuExitImage
                objectName: "menuExitImage"
                source: "tri tochki 1000.png"
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: Theme.dpcm*0.2
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    menu.visible = false
                    osnFon.focus = true
                }
            }

        }

        GridLayout{

            id:settingsColumn
            objectName: "settingsColumn"
            columns: 2
            rowSpacing: Theme.dpcm*0.1

            anchors.top: menuExitButton.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            //anchors.bottom: parent.bottom

//            Rectangle{

//                id:groupTicksPerCircle
//                objectName: "groupTicksPerCircle"
//                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
//                implicitWidth: Theme.dpcm*8
//                implicitHeight: Theme.dpcm*1.4


                Label{
                    id:ticksPerCircleLabel
                    objectName: "ticksPerCircleLabel"
                    text: qsTr("Ticks per circle")
                    font.pointSize: Theme.dpcm*0.4
                    anchors.left: parent.left
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: Theme.dpcm*0.2
                }

                SpinBox{

                    editable: true
                    from: 1
                    to: 999999999
                    value: ticksPerCircle
                    //anchors.right: parent.right
                    //anchors.verticalCenter: parent.verticalCenter
                    Layout.alignment: Qt.AlignCenter
                    onValueModified: {
                        ticksPerCircle = value
                    }

                }


//            }

//            Rectangle{

//                id:groupCircleCount
//                objectName: "groupCircleCount"
//                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
//                implicitWidth: Theme.dpcm*8
//                implicitHeight: Theme.dpcm*1.4


                Label{
                    id:circleCountLabel
                    objectName: "circleCountLabel"
                    text: qsTr("Circle count")
                    font.pointSize: Theme.dpcm*0.4
                    anchors.left: parent.left
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: Theme.dpcm*0.2
                }

                SpinBox{

                    editable: true
                    from: 1
                    to: 999999999
                    value: circleCount
                    //anchors.right: parent.right
                    //anchors.verticalCenter: parent.verticalCenter
                    Layout.alignment: Qt.AlignCenter
                    onValueModified: {
                        circleCount = value
                    }

                }

//            }

//            Rectangle{

//                id:groupVibrateOnTick
//                objectName: "groupVibrateOnTick"
//                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
//                implicitWidth: Theme.dpcm*8
//                implicitHeight: Theme.dpcm*1.4

                Label{
                    id:vibrateOnTickLabel
                    objectName: "vibrateOnTickLabel"
                    text: qsTr("Vibrate on tick")
                    font.pointSize: Theme.dpcm*0.4
                    anchors.left: parent.left
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: Theme.dpcm*0.2
                }

                Switch{

                    //anchors.right: parent.right
                    //anchors.verticalCenter: parent.verticalCenter
                    Layout.alignment: Qt.AlignCenter
                    checked: vibrateOnTick
                    onCheckedChanged: {
                        vibrateOnTick = checked
                    }

                }

//            }

//            Rectangle{

//                id:groupLaguage
//                objectName: "groupLaguage"
//                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
//                implicitWidth: Theme.dpcm*8
//                implicitHeight: Theme.dpcm*1.4

                Label{
                    id:languageChooseLabel
                    objectName: "languageChooseLabel"
                    text: qsTr("Language")
                    font.pointSize: Theme.dpcm*0.4
                    anchors.left: parent.left
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: Theme.dpcm*0.2
                }

                ComboBox {
                    id:chooseLanguageBox
                    objectName: "chooseLanguageBox"
                    //anchors.right: parent.right
                    //anchors.verticalCenter: parent.verticalCenter
                    Layout.alignment: Qt.AlignCenter
                    editable: false
                    textRole: "key"
                    model: ListModel {
                        id:languageListModel
                        objectName: "languageListModel"
                        ListElement { key: "English"; value: "en" }
                        ListElement { key: "Русский"; value: "ru" }
                        ListElement { key: "Буряад"; value: "bua" }
                    }
                    onActivated: {
                        lang = languageListModel.get(currentIndex).value;
                        setLanguage(lang);
                    }
                }

            //}



        }

    }

}
