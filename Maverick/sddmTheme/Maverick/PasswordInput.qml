import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami

TextField {
    id: password

    property string user
    property string session

    signal loginError
    leftPadding: 32
    topPadding: 4
    color: "white"
    echoMode: TextInput.Password

    Connections {
        target: sddm
        onLoginFailed: {
            password.text = ""
            loginError()
        }
    }

    onAccepted: sddm.login(user, password.text,
                           session)

    background: Rectangle {
        anchors.fill: parent
        anchors.centerIn: parent
        radius: 22
        color: "#4DFFFFFF"
        Kirigami.Icon {
            width: 22
            height: 22
            anchors.leftMargin: 8
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            isMask: true
            color: "white"
            opacity: 0.5
            source: Qt.resolvedUrl("images/lock.svg")
        }

    }

}
