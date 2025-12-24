import QtQuick 2.0
import SddmComponents 2.0

Row {
    id: root
    
    spacing: config.intValue("powerButtonSpacing") || 20
    property int buttonSize: config.intValue("powerButtonSize") || 50
    
    // Shutdown button
    Rectangle {
        width: root.buttonSize
        height: root.buttonSize
        radius: width / 2
        color: config.stringValue("powerButtonBackground") || '#333333'
        border.color: config.stringValue("powerButtonBorder") || '#888888'
        border.width: 1
        antialiasing: true
        
        Text {
            text: "⏻"
            color: config.stringValue("textColor") || "#c4c4c4"
            font.pixelSize: root.buttonSize * 0.48
            font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
            anchors.centerIn: parent
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: sddm.powerOff()
        }
    }
    
    // Restart button
    Rectangle {
        width: root.buttonSize
        height: root.buttonSize
        radius: width / 2
        color: config.stringValue("powerButtonBackground") || '#333333'
        border.color: config.stringValue("powerButtonBorder") || '#888888'
        border.width: 1
        antialiasing: true
        
        Text {
            text: "↻"
            color: config.stringValue("textColor") || "#c4c4c4"
            font.pixelSize: root.buttonSize * 0.48
            font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
            anchors.centerIn: parent
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: sddm.reboot()
        }
    }

    // Suspend button
    Rectangle {
        width: root.buttonSize
        height: root.buttonSize
        radius: width / 2
        color: config.stringValue("powerButtonBackground") || '#333333'
        border.color: config.stringValue("powerButtonBorder") || '#888888'
        border.width: 1
        antialiasing: true
        
        Text {
            text: "⏾"
            color: config.stringValue("textColor") || "#c4c4c4"
            font.pixelSize: root.buttonSize * 0.48
            font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
            anchors.centerIn: parent
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: sddm.suspend()
        }
    }
}

