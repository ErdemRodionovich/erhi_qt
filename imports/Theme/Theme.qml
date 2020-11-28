
pragma Singleton

import QtQuick 2.12
import QtQuick.Controls 2.12

QtObject {

    readonly property color gray: "#b2b1b1"
    readonly property color lightGray: "#dddddd"
    readonly property color blue: "#2d548b"
    readonly property color mainColorDarker: Qt.darker(mainColor, 1.5)

    property color mainColor: "#17a81a"
    property color osnFon: "#ffffff"
    property color secondColor: "#2d548b"

    //palette

    property color alternateBase:   "#17a81a"
    property color base:            "#ffffff"
    property color brightText:      "#17a81a"
    property color button:          "#60dfa3"
    property color buttonText:      "#85a8f5"
    property color dark:            "#17a81a"
    property color highlight:       "#97f58c"
    property color highlightedText: "#7bf0e5"
    property color light:           "#17a81a"
    property color link:            "#17a81a"
    property color linkVisited:     "#17a81a"
    property color mid:             "#85a8f5"
    property color midlight:        "#17a81a"
    property color shadow:          "#17a81a"
    property color text:            "#222222"
    property color toolTipBase:     "#17a81a"
    property color toolTipText:     "#17a81a"
    property color window:          "#17a81a"
    property color windowText:      "#17a81a"


    property int baseSize: 10
    property real dpcm: 50
    readonly property int smallSize: 10
    readonly property int largeSize: 16

    property font font
    font.bold: false
    font.underline: false
    font.pointSize: 16
    font.family: "arial"
    //font.color: "#000000"

    property font font_small
    font_small.bold: false
    font_small.underline: false
    font_small.pointSize: 12
    font_small.family: "arial"
    //font_small.color: "#000000"

}
