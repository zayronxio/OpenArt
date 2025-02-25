import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import org.kde.kirigami as Kirigami

Item {
    property string nameUser: "Adolfo"
    property bool active: true
    property string img: Qt.resolvedUrl("faces/fakeWallpaper4.webp")
    property bool isCurrent: true
    property color colorBackground: "#FACE64"
    property color colorDegrad: "#F9C442"
    property bool dialogBool: false
    property bool isFocused: false
    property int selectedSession
    //property var forceFocus: force()

    property int sizeHeightDailog: 0

    FontLoader {
        id: roboto
        source: "fonts/Roboto-Light.ttf"
    }
    signal destroyDialogs

    signal exitSessionMenu(bool isVisible)

    signal error()

    onDialogBoolChanged: {
        sessionMenu.visible = dialogBool
    }

    Component.onCompleted: {
        if(isFocused) {
            Qt.callLater(() => password.forceActiveFocus())
        }

    }


    Rectangle {
        color: "#030010"
        width: parent.width
        height: parent.height
        radius: 24
        MouseArea {
            anchors.fill: parent
            onClicked: {
                destroyDialogs()
            }

        }
        Rectangle {
            id: mask
            width: parent.width - 32
            height: active ? parent.height *.65 : parent.height - 32
            radius: 16
            visible: false
            color: "black"
        }
        Image {
            id: avatar
            width: mask.width
            height: mask.height
            source: img
            fillMode: Image.PreserveAspectCrop
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: mask
            }

            Rectangle {
                id: bgName
                width: parent.width *.6
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                height: 32
                radius: 16
                color: "white"
                opacity: 0.9
            }
            Rectangle {
                width: bgName.width + 1
                height: bgName.height + 1
                radius: bgName.radius
                anchors.centerIn: bgName
                color: "transparent"
                border.color: "black"
                opacity: 0.4
            }
            Rectangle {
                width: bgName.width - 2
                height: bgName.height - 2
                anchors.centerIn: bgName
                radius: bgName.radius
                color: "transparent"
                border.color: "white"
                opacity: 0.12
            }
            Text {
               anchors.fill: bgName
               anchors.centerIn: bgName
               font.pointSize: 14
               verticalAlignment: Text.AlignVCenter
               text: " " + nameUser
               horizontalAlignment:  Text.AlignHCenter
            }
        }

        PasswordInput {
            id: password
            anchors.top: parent.top
            anchors.topMargin: ((parent.height - 32 - avatar.height)/2)
            anchors.left: parent.left
            anchors.leftMargin: 16
            user: nameUser
            session: selectedSession
            width: sessionModel.count > 1 ? parent.width - 72 : parent.width - 32
            height: 32
            visible: active
            onTextChanged: {
                destroyDialogs()
            }
            onLoginError: {
                error()
            }
        }
        function force() {
            password.forceActiveFocus()
        }


    }

}
