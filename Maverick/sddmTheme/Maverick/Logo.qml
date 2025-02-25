import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    property bool isText: true
    property color one
    property color two

    Rectangle {
        id: bg
        width: parent.width
        height: parent.height
        radius: (height/2)
        gradient: Gradient {
            GradientStop { position: 0.0; color: one }
            GradientStop { position: 1.0; color: two }
        }
    }
    DropShadow {
        anchors.fill: bg
        source: bg
        transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 1
        radius: 8
        samples: 20
        color: "#80000000"
    }
    Rectangle {
        anchors.fill: bg
        radius: bg.radius
        color: "transparent"
        border.color: "#80000000"
        border.width: 1
    }
    Rectangle {
        width: bg.width - 2
        height: bg.height - 2
        radius: bg.radius
        anchors.centerIn: bg
        color: "transparent"
        border.color: "#80ffffff"
        border.width: 1
    }
    Text {
        color: "#00012e"
        width: parent.width
        height: parent.height
        text: nameUser[0]
        font.pointSize: parent.height*.35
        //font.bold: true
        visible: isText
        opacity: 0.6
        font.capitalization: Font.Capitalize
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        //style: Text.Raised; styleColor: "gray"
    }
    Image {
        width: parent.width
        height: parent.height
        visible: !isText
        source: Qt.resolvedUrl("images/pl.svg")
    }
}
