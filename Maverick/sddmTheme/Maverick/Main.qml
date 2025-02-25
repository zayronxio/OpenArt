import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts 1.2
import org.kde.plasma.core 2.0 as PlasmaCore
import "components"

Rectangle {
    id: root
    width: 640
    height: 480

    LayoutMirroring.enabled: Qt.locale().textDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property int sizeHeightDailog: 0
    property bool dialogVisible: false
    property int currentElement

    signal exitDialogs

    TextConstants {
        id: textConstants
    }

    // hack for disable autostart QtQuick.VirtualKeyboard
    Loader {
        id: inputPanel
        property bool keyboardActive: false
        source: "components/VirtualKeyboard.qml"
    }


    onExitDialogs: {
        //tooltip.showTooltip("This is a tooltip message!")
        dialogVisible = false
        sessionMenu.visible = false
        panel.clickExit()
    }

    Image {
        id: wallpaper
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop

        Binding on source {
            when: config.background !== undefined
            value: config.background
        }
    }

    Clock {
        width: parent.width
        height: 150
        anchors.top: parent.top
        anchors.topMargin: 32
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            exitDialogs()
        }
    }
    Panel {
        id: panel
        width: 98
        height:24
        anchors.right: parent.right
    }


    ListView {
        id: carouselView
        width: originalWidth
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: 300
        model: userModel
        //visible: false
        orientation: Qt.Horizontal
        spacing: 10
        snapMode: ListView.SnapOneItem
        currentIndex: 0

        property int originalWidth: (parent.width/2) + 150

        // Animación para el desplazamiento
        Behavior on contentX {
            NumberAnimation {
                duration: 600 // Duración de la animación en milisegundos
                easing.type: Easing.InOutQuad // Tipo de easing para suavizar la animación
            }
        }

        delegate: Delegate {
            width: 300
            height: carouselView.currentIndex === model.index ? 300 : 240
            active: carouselView.currentIndex === model.index
            anchors.verticalCenter: parent.verticalCenter
            nameUser: model.name
            img: (model.icon).includes("face.icon") ? Qt.resolvedUrl("images/.face.icon") : model.icon
            isCurrent: model.index === model.lastUser
            isFocused: carouselView.currentIndex === model.index
            selectedSession: listSession.currentIndex
            dialogBool: !dialogVisible ? false : dialogAveilable

            property bool dialogAveilable: false


            MouseArea {
                width: parent.width
                height: parent.active ? parent.height*.65 : parent.height
                anchors.bottom: parent.bottom
                onClicked: {
                    //parent.forceFocus()
                    exitDialogs()
                    carouselView.currentIndex = model.index
                    carouselView.width = carouselView.originalWidth + (model.index * 300)
                }
            }

            Kirigami.Icon {
                id: mesh
                width: 24
                height: width
                isMask: true
                color: "white"
                anchors.left:  parent.right
                anchors.leftMargin: - 16 - width
                anchors.top: parent.top
                anchors.topMargin: parent.height *.135
                source: Qt.resolvedUrl("images/mesh.svgz")
                visible: sessionModel.count > 1 ? parent.active : false
                MouseArea {
                    anchors.fill: mesh
                    z: 16
                    onClicked: {
                        sessionMenu.visible = !sessionMenu.visible
                    }
                }
            }

            onExitSessionMenu: {
                currentElement = model.index
                dialogAveilable = isVisible
                dialogVisible = isVisible
                if (isVisible) {
                    timer.start()
                } else {
                    timer.stop()
                }

            }
            Timer {
                id: timer
                interval: 50
                running: false
                repeat: true
                onTriggered: {
                    dialogBool = !dialogVisible ? false : dialogAveilable
                }
            }

            onDialogBoolChanged: {
                if (!dialogBool) {
                    timer.stop()
                }
            }

            onDestroyDialogs: {
                exitDialogs()
            }
            onError: {
                tooltip.showTooltip("Error, please verify your password!")
            }

        }
    }
    DialogCard {
        id: sessionMenu
        width: 175
        height: sizeHeightDailog + Kirigami.Units.largeSpacing*2 + sessionMenu.marginHeader
        visible: false
        anchors.top: carouselView.top
        anchors.topMargin: 66
        anchors.left: carouselView.left
        anchors.leftMargin: (carouselView.currentIndex*300) + (carouselView.currentIndex*10) + 185
        z: 15
        Item {
            id: bg
            width: parent.width
            height: listSession.height
            anchors.top: parent.top
            anchors.topMargin: parent.marginHeader + Kirigami.Units.largeSpacing + Kirigami.Units.mediumSpacing

            ListView {
                id: listSession
                width: parent.width - Kirigami.Units.largeSpacing * 2
                model: sessionModel
                currentIndex: sessionModel.lastIndex
                height: sizeHeightDailog
                anchors.centerIn: parent
                interactive: false // Desactiva el scroll para que todo el contenido sea visible

                delegate: CheckBox {
                    id: element
                    width: listSession.width
                    contentItem: Text {
                        text: model.name
                        font: control.font
                        color: "black"
                        leftPadding: 22
                        verticalAlignment: Text.AlignVCenter
                    }
                    font.family: roboto.name
                    font.weight: Font.Medium
                    checked: listSession.currentIndex === model.index
                    onCheckedChanged: {
                        if (checked){
                            listSession.currentIndex = model.index
                        }
                    }
                    Component.onCompleted: {
                        sizeHeightDailog = sizeHeightDailog + element.implicitHeight
                        //parent.height = text.implicitHeight
                    }
                }
            }
        }
    }
    TooltipError {
        id: tooltip
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Kirigami.Units.largeSpacing*2
    }

}
