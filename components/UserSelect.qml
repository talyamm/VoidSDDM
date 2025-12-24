import QtQuick 2.0
import SddmComponents 2.0

Row {
    id: root
    property int selectedIndex: userModel.lastIndex
    property string selectedUser: userRepeater.count > 0 ? userRepeater.itemAt(root.selectedIndex).userName : ""
    property alias userCount: userRepeater.count
    
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
                    root.selectedIndex = userRepeater.count - 1
                }
            }
        }
    }

    // User name display
    Rectangle {
        width: root.width - 60 - (root.spacing * 2)
        height: 35
        color: config.stringValue("selectorBackground") || '#000000'
        clip: true

        Text {
            id: userText
            text: root.selectedUser
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
                if (root.selectedIndex < userRepeater.count - 1) {
                    root.selectedIndex++
                } else {
                    root.selectedIndex = 0
                }
            }
        }
    }
    
    // Hidden repeater to store user data
    Repeater {
        id: userRepeater
        model: userModel
        delegate: Item {
            property string userName: name
        }
    }
}