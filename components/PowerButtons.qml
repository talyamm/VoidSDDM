import QtQuick 2.0
import SddmComponents 2.0

Row {
    id: root
    
    spacing: config.intValue("powerButtonSpacing") || 20
    property int buttonSize: config.intValue("powerButtonSize") || 50
    property int activeButton: -1 // -1 = none, 0 = shutdown, 1 = restart, 2 = suspend
    
    // Shutdown button
    Rectangle {
        id: shutdownButton
        width: root.buttonSize
        height: root.buttonSize
        radius: width / 2
        color: config.stringValue("powerButtonBackground") || '#333333'
        border.color: root.activeButton === 0 ? (config.stringValue("powerButtonBorderActive") || config.stringValue("passwordFieldBorderActive") || '#aaaaaa') : (config.stringValue("powerButtonBorder") || '#888888')
        border.width: root.activeButton === 0 ? 2 : 1
        antialiasing: true
        
        Behavior on border.width {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
        
        Behavior on border.color {
            ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
        
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
        id: restartButton
        width: root.buttonSize
        height: root.buttonSize
        radius: width / 2
        color: config.stringValue("powerButtonBackground") || '#333333'
        border.color: root.activeButton === 1 ? (config.stringValue("powerButtonBorderActive") || config.stringValue("passwordFieldBorderActive") || '#aaaaaa') : (config.stringValue("powerButtonBorder") || '#888888')
        border.width: root.activeButton === 1 ? 2 : 1
        antialiasing: true
        
        Behavior on border.width {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
        
        Behavior on border.color {
            ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
        
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
        id: suspendButton
        width: root.buttonSize
        height: root.buttonSize
        radius: width / 2
        color: config.stringValue("powerButtonBackground") || '#333333'
        border.color: root.activeButton === 2 ? (config.stringValue("powerButtonBorderActive") || config.stringValue("passwordFieldBorderActive") || '#aaaaaa') : (config.stringValue("powerButtonBorder") || '#888888')
        border.width: root.activeButton === 2 ? 2 : 1
        antialiasing: true
        
        Behavior on border.width {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
        
        Behavior on border.color {
            ColorAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
        
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

