import QtQuick 2.0
import SddmComponents 2.0

Row {
    id: root
    
    spacing: config.intValue("powerButtonSpacing") || 20
    property int buttonSize: config.intValue("powerButtonSize") || 50
    property int activeButton: -1 // -1 = none, 0 = shutdown, 1 = restart, 2 = suspend (from keyboard)
    property int hoveredButton: -1 // -1 = none, 0 = shutdown, 1 = restart, 2 = suspend (from mouse)
    property bool fadeInComplete: true
    property int fadeInDuration: 300
    
    // Effective active button: hover takes priority over keyboard
    property int effectiveActiveButton: hoveredButton !== -1 ? hoveredButton : activeButton
    
    opacity: root.fadeInComplete ? 1 : 0
    
    Behavior on opacity {
        NumberAnimation { duration: root.fadeInDuration; easing.type: Easing.OutCubic }
    }
    
    // Shutdown button
    Rectangle {
        id: shutdownButton
        width: root.buttonSize
        height: root.buttonSize
        radius: width / 2
        color: config.stringValue("powerButtonBackground") || '#333333'
        border.color: root.effectiveActiveButton === 0 ? (config.stringValue("powerButtonBorderActive") || config.stringValue("passwordFieldBorderActive") || '#aaaaaa') : (config.stringValue("powerButtonBorder") || '#888888')
        border.width: root.effectiveActiveButton === 0 ? 2 : 1
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
            hoverEnabled: true
            onEntered: root.hoveredButton = 0
            onExited: root.hoveredButton = -1
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
        border.color: root.effectiveActiveButton === 1 ? (config.stringValue("powerButtonBorderActive") || config.stringValue("passwordFieldBorderActive") || '#aaaaaa') : (config.stringValue("powerButtonBorder") || '#888888')
        border.width: root.effectiveActiveButton === 1 ? 2 : 1
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
            hoverEnabled: true
            onEntered: root.hoveredButton = 1
            onExited: root.hoveredButton = -1
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
        border.color: root.effectiveActiveButton === 2 ? (config.stringValue("powerButtonBorderActive") || config.stringValue("passwordFieldBorderActive") || '#aaaaaa') : (config.stringValue("powerButtonBorder") || '#888888')
        border.width: root.effectiveActiveButton === 2 ? 2 : 1
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
            hoverEnabled: true
            onEntered: root.hoveredButton = 2
            onExited: root.hoveredButton = -1
            onClicked: sddm.suspend()
        }
    }
}

