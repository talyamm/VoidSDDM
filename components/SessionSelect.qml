import QtQuick 2.0
import SddmComponents 2.0

Row {
    id: root
    property int selectedIndex: sessionModel.lastIndex
    property alias sessionCount: sessionRepeater.count
    
    spacing: config.intValue("selectorSpacing") || 10
    
    // Left arrow button
    Rectangle {
        width: 30
        height: 35
        color: config.stringValue("selectorBackground") || '#000000'

        Text {
            text: "<"
            color: config.stringValue("textColor") || "#c4c4c4"
            font.pixelSize: config.intValue("selectorArrowFontSize") || 18
            font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.selectedIndex > 0) {
                    root.selectedIndex--
                } else {
                    root.selectedIndex = sessionRepeater.count - 1
                }
            }
        }
    }

    // Session name display
    Rectangle {
        width: root.width - 60 - (root.spacing * 2)
        height: 35
        color: config.stringValue("selectorBackground") || '#000000'
        clip: true

        Text {
            id: sessionText
            text: sessionRepeater.count > 0 ? sessionRepeater.itemAt(root.selectedIndex).sessionName : ""
            color: config.stringValue("textColor") || "#c4c4c4"
            font.pixelSize: config.intValue("selectorFontSize") || 14
            font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
        }
    }

    // Right arrow button
    Rectangle {
        width: 30
        height: 35
        color: config.stringValue("selectorBackground") || '#000000'

        Text {
            text: ">"
            color: config.stringValue("textColor") || "#c4c4c4"
            font.pixelSize: config.intValue("selectorArrowFontSize") || 18
            font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.selectedIndex < sessionRepeater.count - 1) {
                    root.selectedIndex++
                } else {
                    root.selectedIndex = 0
                }
            }
        }
    }
    
    // Hidden repeater to store session data
    Repeater {
        id: sessionRepeater
        model: sessionModel
        delegate: Item {
            property string sessionName: name
        }
    }
}