import QtQuick 2.0
import SddmComponents 2.0

Row {
    id: root
    spacing: 10
    
    property int selectedIndex: sessionModel.lastIndex
    
    // Left arrow button
    Rectangle {
        width: 30
        height: 35
        color: '#000000'

        Text {
            text: "<"
            color: "#c4c4c4"
            font.pixelSize: 18
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
        width: 170
        height: 35
        color: '#000000'

        Text {
            id: sessionText
            text: sessionRepeater.count > 0 ? sessionRepeater.itemAt(root.selectedIndex).sessionName : ""
            color: "#c4c4c4"
            font.pixelSize: 14
            anchors.centerIn: parent
        }
    }

    // Right arrow button
    Rectangle {
        width: 30
        height: 35
        color: '#000000'

        Text {
            text: ">"
            color: "#c4c4c4"
            font.pixelSize: 18
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