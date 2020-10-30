import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Erhi")

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 640
        height: 30
        color: "#ffffff"
    }

    Rectangle {
        id: rectangle1
        x: 0
        y: 36
        width: 640
        height: 444
        color: "#ffffff"

        Image {
            id: image
            x: 0
            y: 8
            width: 640
            height: 436
            source: "chetki.jpg"
            fillMode: Image.PreserveAspectFit
        }
    }

    Image {
        id: image1
        x: 0
        y: 0
        width: 52
        height: 43
        source: "tri tochki png.png"
        clip: false
        fillMode: Image.PreserveAspectFit
    }
}
