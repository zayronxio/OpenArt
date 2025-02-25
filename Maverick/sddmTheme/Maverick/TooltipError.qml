import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: tooltip
    property string txByTooltip: ""
    property int duration: 3000 // Duration to display the tooltip in milliseconds

    width: Math.min((parent.width / 3), 304)
    height: 40
    visible: false
    opacity: 0


    Item {
        id: container
        anchors.fill: parent
        scale: 1

        Rectangle {
            id: bg
            color: "black"
            anchors.fill: parent
            opacity: 0.4
            radius: 8
        }
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: "black"
            border.width: 1
            radius: 8
            opacity: 0.7
        }
        Rectangle {
            width: parent.width - 2
            height: parent.height - 2
            radius: 8
            border.color: "white"
            border.width: 1
            color: "transparent"
            opacity: 0.08
            anchors.centerIn: parent
        }
        Text {
            color: "white"
            text: txByTooltip
            anchors.fill: parent
            font.pointSize: 9
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    ScaleAnimator {
        target: container
        from: 0.1
        to: 1
        duration: 120
        running: visible
    }

    Timer {
        id: hideTimer
        interval: duration
        running: false
        repeat: false
        onTriggered: {
            disappearAnim.running = true
        }
    }

    SequentialAnimation {
        id: disappearAnim
        running: false

        ParallelAnimation {
            PropertyAnimation {
                target: container
                property: "opacity"
                to: 0
                duration: 500
            }
            PropertyAnimation {
                target: container
                property: "scale"
                to: 0.1
                duration: 100
            }
        }
        ScriptAction {
            script: {
                tooltip.visible = false
                tooltip.opacity = 0
                container.opacity = 1
                container.scale = 1
            }
        }
    }

    function showTooltip(text) {
        txByTooltip = text
        visible = true
        opacity = 1
        hideTimer.start()
    }
}
