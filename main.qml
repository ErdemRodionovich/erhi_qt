import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Erhi")

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

        }

        curCount_Txt.text = curTicks;
        curCircle_Txt.text = curCircles;

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
}
