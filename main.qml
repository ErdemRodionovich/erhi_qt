import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import Theme 1.0
import QtMultimedia 5.12


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
    property int soundNumberOnCircle: 0
    property bool soundOnCircle: true
    property bool vibrateOnTick: true
    property bool vibrateOnCircle: true
    property string lang: "en"

    function onTick(){

        curTicks++;

        if (vibrateOnTick){
            vibrate(100);
        }

        if(soundOnTick){
            snd.pl(soundNumberOnTick);
        }

        if(curTicks >= ticksPerCircle){

            curCircles++;
            curTicks=0;

            if(curCircles >= circleCount){
                curCircles=0;
            }

            if(vibrateOnCircle){
                vibrate(1000);
            }
            if(soundOnCircle){
                snd.pl(soundNumberOnCircle);
            }

        }

        curCount_Txt.text = curTicks;
        curCircle_Txt.text = curCircles;

    }

    function updateTexts(){

        /*mainWindow.title = qsTr("Erhi");
        ticksPerCircleLabel.text = qsTr("Ticks per circle");
        circleCountLabel.text = qsTr("Circle count");
        vibrateOnTickLabel.text = qsTr("Vibrate on tick");*/
/*
        for(var i=0; i<snd_lst.count;i++){
            snd_lst.get(i).text = qsTr(snd_lst.get(i).key);
        }

        for(var i=0;i<snd_lst.count;i++){

            soundNumberOnCircleChooseBox.model.get(i).text = qsTr(soundNumberOnCircleChooseBox.model.get(i).key);
            soundOnTickChooseBox.model.get(i).text = qsTr(soundOnTickChooseBox.model.get(i).key);

        }
        soundNumberOnCircleChooseBox.displayText = qsTr(soundNumberOnCircleChooseBox.model.get(soundNumberOnCircleChooseBox.currentIndex).key);
        soundOnTickChooseBox.displayText = qsTr(soundOnTickChooseBox.model.get(soundOnTickChooseBox.currentIndex).key);
        soundOnTickChooseBox.model.sync();
        soundNumberOnCircleChooseBox.model.sync();*/

        soundOnTickChooseBox.model = snd_lst;
        soundOnTickChooseBox.currentIndex = soundNumberOnTick;
        soundNumberOnCircleChooseBox.model = snd_lst;
        soundNumberOnCircleChooseBox.currentIndex = soundNumberOnCircle;

    }

    function set_dpcm(d){
        Theme.dpcm = d;
    }

    Audio{
        id:snd
        objectName: "snd"
        playlist: Playlist{
            id: snd_plst
            objectName: "snd_plst"
            playbackMode: Playlist.CurrentItemOnce;
            PlaylistItem{source: "sounds/160052__jorickhoofd__metal-short-tick.mp3";}
            PlaylistItem{source: "sounds/relaxing-bell-ding-sound.mp3";}
            PlaylistItem{source: "sounds/Ding-sound-effect.mp3";}
            PlaylistItem{source: "sounds/Magical-chimes-bells-down-sound-effect.mp3";}
            PlaylistItem{source: "sounds/Magical-chimes-bells-up-sound-effect.mp3";}
        }
        volume: 1.0
        function pl(i){
            if(snd.playbackState == Audio.PlayingState){
                snd.stop();
            }
            snd_plst.currentIndex = i;
            snd.play();
        }
    }
    ListModel{
        id:snd_lst
        objectName: "snd_lst"
        ListElement{key:qsTr("Metal short");}//  text:qsTr("Metal short"); value:0;}
        ListElement{key:qsTr("Bell ding");  }//  text:qsTr("Bell ding"); value:1;}
        ListElement{key:qsTr("Ding");       }//  text:qsTr("Ding"); value:2;}
        ListElement{key:qsTr("Bells down"); }//  text:qsTr("Bells down"); value:3;}
        ListElement{key:qsTr("Bells up");   }//  text:qsTr("Bells up"); value:4;}
    }

    Rectangle {
        id: footer
        objectName: "footer"
        x: 0
        y: 0
        width: parent.width
        height: Theme.dpcm
        color: Theme.osnFon

        Rectangle {
            id: menu_button
            objectName: "menu_button"
            anchors.left: footer.left
            anchors.top: footer.top
            anchors.bottom: footer.bottom
            width: Theme.dpcm
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
                    for(var i=0;i<snd_lst.count;i++){
                        if(soundNumberOnCircle == i){
                            soundNumberOnCircleChooseBox.currentIndex = i;
                            //soundNumberOnCircleChooseBox.displayText = snd_lst.get(i).text; //qsTr(soundNumberOnCircleChooseBox.currentText);
                        }
                        if(soundNumberOnTick == i){
                            soundOnTickChooseBox.currentIndex = i;
                            //soundOnTickChooseBox.displayText = snd_lst.get(i).text; //qsTr(soundOnTickChooseBox.currentText);
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
            width: Theme.dpcm
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
            height: Theme.dpcm
            width: Theme.dpcm

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
            Layout.alignment: Qt.AlignLeft
            property real c2_width: Theme.dpcm*2.5
            property real c2_height: Theme.dpcm*1.5
            property real c1_width: Theme.dpcm*3
            property real c1_height: Theme.dpcm*1.5
            property real c1_leftMargin: Theme.dpcm*0.2

            Text{
                id:ticksPerCircleLabel
                objectName: "ticksPerCircleLabel"
                width: parent.c1_width
                text: qsTr("Ticks per circle")
                wrapMode: Text.WordWrap
                Layout.leftMargin: parent.c1_leftMargin
                font: Theme.font
                Layout.maximumWidth: parent.c1_width
            }

            SpinBox{

                editable: true
                from: 1
                to: 999999999
                value: ticksPerCircle
                Layout.alignment: Qt.AlignCenter
                //implicitHeight: parent.c2_height
                implicitWidth: parent.c2_width
                font: Theme.font
                onValueModified: {
                    ticksPerCircle = value
                }

            }

            Text{
                id:circleCountLabel
                objectName: "circleCountLabel"
                text: qsTr("Circle count")
                width: parent.c1_width
                padding: 0
                wrapMode: Text.WordWrap
                Layout.leftMargin: parent.c1_leftMargin
                font: Theme.font
                Layout.maximumWidth: parent.c1_width
            }

            SpinBox{

                editable: true
                from: 1
                to: 999999999
                value: circleCount
                Layout.alignment: Qt.AlignCenter
                font: Theme.font
                implicitWidth: parent.c2_width
                onValueModified: {
                    circleCount = value
                }

            }

            Text{
                id:vibrateOnTickLabel
                objectName: "vibrateOnTickLabel"
                text: qsTr("Vibrate on tick")
                width: parent.c1_width
                Layout.maximumWidth: parent.c1_width
                padding: 0
                wrapMode: Text.WordWrap
                Layout.leftMargin: parent.c1_leftMargin
                font: Theme.font
            }

            Switch{

                Layout.alignment: Qt.AlignCenter
                checked: vibrateOnTick
                font: Theme.font
                implicitWidth: parent.c2_width
                onCheckedChanged: {
                    vibrateOnTick = checked
                }

            }

            Text{
                id:languageChooseLabel
                objectName: "languageChooseLabel"
                text: qsTr("Language")
                width: parent.c1_width
                padding: 0
                wrapMode: Text.WordWrap
                Layout.leftMargin: parent.c1_leftMargin
                font: Theme.font
                Layout.maximumWidth: parent.c1_width
            }

            ComboBox {
                id:chooseLanguageBox
                objectName: "chooseLanguageBox"
                Layout.alignment: Qt.AlignCenter
                implicitWidth: parent.c2_width
                editable: false
                textRole: "key"
                font: Theme.font
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

            Text{
                id:playSoundOnTickLabel
                objectName: "playSoundOnTickLabel"
                text: qsTr("Play sound on tick")
                width: parent.c1_width
                wrapMode: Text.WordWrap
                Layout.leftMargin: parent.c1_leftMargin
                font: Theme.font
                Layout.maximumWidth: parent.c1_width
            }

            Switch{

                Layout.alignment: Qt.AlignCenter
                checked: soundOnTick
                font: Theme.font
                implicitWidth: parent.c2_width
                onCheckedChanged: {
                    soundOnTick = checked
                }

            }

            Text{
                id:soundNumberOnTickLabel
                objectName: "soundNumberOnTickLabel"
                text: qsTr("Sound on tick");
                width: parent.c1_width
                wrapMode: Text.Wrap
                Layout.leftMargin: parent.c1_leftMargin
                font: Theme.font
                Layout.maximumWidth: parent.c1_width
            }

            ComboBox{
                id:soundOnTickChooseBox
                objectName: "soundOnTickChooseBox"
                Layout.alignment: Qt.AlignCenter
                implicitWidth: parent.c2_width
                editable: false;
                textRole: "key"
                font: Theme.font
                model: snd_lst
                displayText: snd_lst.get(currentIndex).key
                onActivated: {
                    soundNumberOnTick = currentIndex
                    snd.pl(soundNumberOnTick);
                }
            }

            Text{
                id:playSoundOnCircleLabel
                objectName: "playSoundOnCircleLabel"
                text: qsTr("Play sound on circle")
                width: parent.c1_width
                wrapMode: Text.WordWrap
                Layout.leftMargin: parent.c1_leftMargin
                font: Theme.font
                Layout.maximumWidth: parent.c1_width
            }

            Switch{

                Layout.alignment: Qt.AlignCenter
                checked: soundOnCircle
                font: Theme.font
                implicitWidth: parent.c2_width
                onCheckedChanged: {
                    soundOnCircle = checked
                }

            }

            Text{
                id:soundNumberOnCircleLabel
                objectName: "soundNumberOnCircleLabel"
                text: qsTr("Sound on circle");
                width: parent.c1_width
                wrapMode: Text.Wrap
                Layout.leftMargin: parent.c1_leftMargin
                font: Theme.font
                Layout.maximumWidth: parent.c1_width
            }

            ComboBox{
                id:soundNumberOnCircleChooseBox
                objectName: "soundNumberOnCircleChooseBox"
                Layout.alignment: Qt.AlignCenter
                implicitWidth: parent.c2_width
                editable: false;
                textRole: "key"
                font: Theme.font
                model: snd_lst
                displayText: snd_lst.get(currentIndex).key
                onActivated: {
                    soundNumberOnCircle = currentIndex
                    snd.pl(soundNumberOnCircle);
                }
            }

        }

    }

}
