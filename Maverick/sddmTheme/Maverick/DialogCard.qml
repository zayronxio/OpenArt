import QtQuick
import org.kde.ksvg 1.0 as KSvg
import Qt5Compat.GraphicalEffects

Item {

    property url pathSvg: Qt.resolvedUrl("images/dialog.svgz")

    KSvg.Svg {
        id: svg
        imagePath: pathSvg
    }

    function sizeOfSvg(element,type,size){
        if (type === "width") {
            if (excludesWidth.indexOf(element) > -1) {
                if (element === "center-top" || element === "center" || element === "bottom-center" ) {
                    return centerTop.implicitWidth
                } else {
                    return topleft.implicitWidth
                }
            } else {
                var value = (size - ((topleft.implicitWidth*2) + centerTop.implicitWidth))/2
                return value
            }
        } else if (type === "height") {
            if (excludesHeight.indexOf(element) > -1) {
                if (element === "center-top") {
                    return centerTop.implicitHeight
                } else {
                    return topleft.implicitHeight
                }
            } else {
                var value = size - (topleft.implicitHeight + centerTop.implicitHeight)
                return value
            }
        }
    }

    property int marginHeader: centerTop.implicitHeight - topleft.implicitHeight
    property var namesItemsSvg: ["top-left", "center-top-left", "center-top",
    "center-top-right", "top-right", "left",
    "center-left", "center", "center-right", "right", "bottom-left", "botton-center-left", "bottom-center", "bottom-center-right", "bottom-right"]

    property var excludesWidth: ["top-left", "center-top", "top-right", "left", "center", "right", "bottom-left",  "bottom-center", "bottom-right"]

    property var excludesHeight: ["top-left", "center-top-left", "center-top",
    "center-top-right", "top-right", "bottom-left", "botton-center-left", "bottom-center", "bottom-center-right", "bottom-right"]

    property var marginTargets: ["top-left", "center-top-left", "center-top-right", "top-right"]

    KSvg.SvgItem {
        id: topleft
        imagePath: pathSvg
        elementId: "top-left"
        visible: false
    }
    KSvg.SvgItem {
        id: centerTop
        imagePath: pathSvg
        elementId: "center-top"
        visible: false
    }

    Grid {
        id: background
        columns: 5
        rows: 3
        width: parent.width
        height: parent.height + marginHeader
        // Fila superior (5 elementos)
        Item { id: topLeft; width: sizeOfSvg("top-left", "width", parent.width); height: sizeOfSvg("top-left", "height", parent.height);
            KSvg.SvgItem { elementId: "top-left"; svg: svg; width: parent.width; height: parent.height; anchors.top: parent.top; anchors.topMargin: marginHeader; }
        }
        Item { id: centerTopLeft; width: sizeOfSvg("center-top-left", "width", parent.width); height: sizeOfSvg("center-top-left", "height", parent.height);
            KSvg.SvgItem { elementId: "center-top-left"; svg: svg; width: parent.width; height: parent.height; anchors.top: parent.top; anchors.topMargin: marginHeader; }
        }
        Item { id: centerTopv; width: sizeOfSvg("center-top", "width", parent.width); height: sizeOfSvg("center-top", "height", parent.height);
            KSvg.SvgItem { elementId: "center-top"; svg: svg; width: parent.width; height: parent.height }
        }
        Item { id: centerTopRight; width: sizeOfSvg("center-top-right", "width", parent.width); height: sizeOfSvg("center-top-right", "height", parent.height);
            KSvg.SvgItem { elementId: "center-top-right"; svg: svg; width: parent.width; height: parent.height; anchors.top: parent.top; anchors.topMargin: marginHeader; }
        }
        Item { id: topRight; width: sizeOfSvg("top-right", "width", parent.width); height: sizeOfSvg("top-right", "height", parent.height);
            KSvg.SvgItem { elementId: "top-right"; svg: svg; width: parent.width; height: parent.height; anchors.top: parent.top; anchors.topMargin: marginHeader; }
        }

        // Fila media (5 elementos)
        Item { id: left; width: sizeOfSvg("left", "width", parent.width); height: sizeOfSvg("left", "height", parent.height);
            KSvg.SvgItem { elementId: "left"; svg: svg; width: parent.width; height: parent.height }
        }
        Item { id: centerLeft; width: sizeOfSvg("center-left", "width", parent.width); height: sizeOfSvg("center-left", "height", parent.height);
            KSvg.SvgItem { elementId: "center-left"; svg: svg; width: parent.width; height: parent.height }
        }
        Item { id: center; width: sizeOfSvg("center", "width", parent.width); height: sizeOfSvg("center", "height", parent.height);
            KSvg.SvgItem { elementId: "center"; svg: svg; width: parent.width; height: parent.height }
        }
        Item { id: centerRight; width: sizeOfSvg("center-right", "width", parent.width); height: sizeOfSvg("center-right", "height", parent.height);
            KSvg.SvgItem { elementId: "center-right"; svg: svg; width: parent.width; height: parent.height }
        }
        Item { id: right; width: sizeOfSvg("right", "width", parent.width); height: sizeOfSvg("right", "height", parent.height);
            KSvg.SvgItem { elementId: "right"; svg: svg; width: parent.width; height: parent.height }
        }

        // Fila inferior (5 elementos)
        Item { id: bottomLeft; width: sizeOfSvg("bottom-left", "width", parent.width); height: sizeOfSvg("bottom-left", "height", parent.height);
            KSvg.SvgItem { elementId: "bottom-left"; svg: svg; width: parent.width; height: parent.height }
        }
        Item { id: bottomCenterLeft; width: sizeOfSvg("botton-center-left", "width", parent.width); height: sizeOfSvg("botton-center-left", "height", parent.height);
            KSvg.SvgItem { elementId: "botton-center-left"; svg: svg; width: parent.width; height: parent.height }
        }
        Item { id: bottomCenter; width: sizeOfSvg("bottom-center", "width", parent.width); height: sizeOfSvg("bottom-center", "height", parent.height);
            KSvg.SvgItem { elementId: "bottom-center"; svg: svg; width: parent.width; height: parent.height }
        }
        Item { id: bottomCenterRight; width: sizeOfSvg("bottom-center-right", "width", parent.width); height: sizeOfSvg("bottom-center-right", "height", parent.height);
            KSvg.SvgItem { elementId: "bottom-center-right"; svg: svg; width: parent.width; height: parent.height }
        }
        Item { id: bottomRight; width: sizeOfSvg("bottom-right", "width", parent.width); height: sizeOfSvg("bottom-right", "height", parent.height);
            KSvg.SvgItem { elementId: "bottom-right"; svg: svg; width: parent.width; height: parent.height }
        }

    }
    DropShadow {
        anchors.fill: background
        source: background
        //transparentBorder: true
        horizontalOffset: 0
        verticalOffset: 1
        radius: 8
        samples: 20
        color: "#80000000"
    }
}
