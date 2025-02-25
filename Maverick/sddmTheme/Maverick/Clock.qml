import QtQuick
import org.kde.kirigami as Kirigami
import Qt5Compat.GraphicalEffects

Item {

    property string textDate: abbr(getDate("d")) + " " + abbr(getDate("m")) + " " + Qt.formatDateTime(new Date(), "d");
    property string time: Qt.formatDateTime(new Date(), "h:mm");
    property color clockColor: "#030010"

    FontLoader {
        id: roboto
        source: "fonts/Roboto-SemiBold.ttf"
    }


    function getDate(type) {
        var value = type === "d" ? "dddd" : type === "m" ? "MMMM" : ""
        var date = new Date();
        var name = date.toLocaleString(Qt.locale(), value);
        return name;
    }

    function abbr(text) {
        var value = ""
        for (var u = 0; u < 3; u++) {
            value = value + text[u]
        }
        return value
    }

    Column {
        id: bg
        width: parent.width
        height: parent.height
        opacity: 0.7
        Text {
            width: parent.width
            color: clockColor
            font.pointSize: 98
            font.family: roboto.name
            font.capitalization: Font.Capitalize
            //font.bold: true
            font.weight: Font.DemiBold
            //renderType: Text.CurveRendering
            text: time
            horizontalAlignment:  Text.AlignHCenter
        }

        Text {
            width: parent.width
            color: clockColor
            font.pointSize: 22
            horizontalAlignment:  Text.AlignHCenter
            font.family: roboto.name
            //renderType: Text.CurveRendering
            font.weight: Font.DemiBold
            font.capitalization: Font.Capitalize
            text: textDate
        }
    }

}
