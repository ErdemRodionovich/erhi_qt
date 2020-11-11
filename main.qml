import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5


Window {
    id:mainWindow
    objectName: "mainWindow"
    width: 640
    height: 480
    visible: true
    title: qsTr("Erhi")

    signal vibrate(int duration)

    property int curTicks: 0
    property int curCircles: 0
    property int circleCount: 10
    property int ticksPerCircle: 10

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

        //vibrate(100);

    }

    Rectangle {
        id: footer
        objectName: "footer"
        x: 0
        y: 0
        width: parent.width
        height: 30
        color: "#ffffff"

        Image {
            id: menu_button
            objectName: "menu_button"
            anchors.left: footer.left
            anchors.top: footer.top
            anchors.bottom: footer.bottom
            anchors.margins: 8
            width: 44
            source: "tri tochki 1000.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onClicked: menu.visible = true
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
            width: 64
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
        id: menu
        objectName: "menu"
        visible: false
        x:0
        y:0
        width: parent.width
        height: parent.height

        Image {
            id: menu_button_in_menu
            objectName: "menu_button_in_menu"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 8
            height: 30
            width: 44
            source: "tri tochki 1000.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    menu.visible = false
                    ticksPerCircle_Edit.focus = false
                    circleCount_Edit.focus = false
                }
            }
        }

        Rectangle{

            id:ticksPerCircle_Edit_Group
            objectName: "ticksPerCircle_Edit_Group"
            anchors.top: menu_button_in_menu.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 30

            Text{

                id:ticksPerCircle_Edit_Label
                objectName: "ticksPerCircle_Edit_Label"
                anchors.top: parent.top
                anchors.left: parent.left
                text: qsTr("Ticks per circle:")
                font.pointSize: 20
                font.family: "Arial"

            }

            TextInput{

                id:ticksPerCircle_Edit
                objectName: "ticksPerCircle_Edit"

                anchors.left: ticksPerCircle_Edit_Label.right
                //anchors.right: parent.right
                anchors.top: parent.top
                font.pointSize: 20
                inputMask: "999999"
                text: ticksPerCircle
                onTextEdited: {
                    if(text == 0){
                        text = 1
                    }
                    ticksPerCircle = text
                }

            }

            SpinBox{

                id:ticksPerCircle_Edit_SpinBox
                objectName: "ticksPerCircle_Edit_SpinBox"
                from:1
                value: ticksPerCircle
                to:999
                stepSize: 1
                anchors.left: ticksPerCircle_Edit.right
                anchors.top: parent.top


            }


        }

        Rectangle{

            id:circleCount_Edit_Group
            objectName: "circleCount_Edit_Group"
            anchors.top: ticksPerCircle_Edit_Group.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            Text {
                id: circleCount_Edit_Label
                objectName: "circleCount_Edit_Label"
                text: qsTr("Circle count:")
                font.pointSize: 20
                font.family: "Arial"
                anchors.top: parent.top
                anchors.left: parent.left
            }

            TextInput{

                id:circleCount_Edit
                objectName: "circleCount_Edit"
                inputMask: "999999"
                text: circleCount
                font.pointSize: 20
                font.family: "Arial"
                anchors.left: circleCount_Edit_Label.right
                anchors.top: parent.top
                anchors.right: parent.right
                onTextEdited: {
                    if(text == 0){
                        text = 1
                    }
                    circleCount = text
                }

            }

        }

    }

}
