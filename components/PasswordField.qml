import QtQuick 2.0

Rectangle {
    id: root
    clip: true
    antialiasing: true
    
    property alias passwordInput: passwordInput
    property alias passwordText: passwordInput.text
    property bool enabled: true
    
    // Config properties
    width: config.intValue("passwordFieldWidth") || 250
    height: config.intValue("passwordFieldHeight") || 35
    color: config.stringValue("passwordFieldBackground") || '#333333'
    radius: config.intValue("passwordFieldRadius") || 16
    border.color: root.enabled ? 
        (config.stringValue("passwordFieldBorderActive") || '#aaaaaa') : 
        (config.stringValue("passwordFieldBorder") || '#888888')
    border.width: root.enabled ? 
        (config.intValue("passwordFieldBorderWidthActive") || 2) : 
        (config.intValue("passwordFieldBorderWidth") || 1)
    property int animationDuration: config.intValue("animationDuration") || 200
    property int sideMargin: config.intValue("passwordFieldMargin") || 20
    
    signal loginRequested()
    
    Behavior on border.width {
        NumberAnimation { duration: root.animationDuration; easing.type: Easing.OutCubic }
    }
    
    Behavior on border.color {
        ColorAnimation { duration: root.animationDuration; easing.type: Easing.OutCubic }
    }
    
    // Subtle glow effect when selected
    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: "transparent"
        border.color: root.enabled ? '#cccccc' : 'transparent'
        border.width: root.enabled ? 1 : 0
        opacity: root.enabled ? 0.3 : 0
        antialiasing: true
        
        Behavior on opacity {
            NumberAnimation { duration: root.animationDuration; easing.type: Easing.OutCubic }
        }
        
        Behavior on border.width {
            NumberAnimation { duration: root.animationDuration; easing.type: Easing.OutCubic }
        }
    }
    
    Item {
        anchors.fill: parent
        anchors.leftMargin: root.sideMargin
        anchors.rightMargin: root.sideMargin
        clip: true
        
        TextInput {
            id: passwordInput
            anchors.fill: parent
            color: config.stringValue("textColor") || "#c4c4c4"
            echoMode: TextInput.Password
            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
            font.pixelSize: config.intValue("passwordFieldFontSize") || 16
            font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
            font.letterSpacing: config.intValue("passwordFieldLetterSpacing") || 2
            passwordCharacter: {
                var maskChar = config.stringValue("passwordCharacter")
                return (maskChar && maskChar !== "") ? maskChar : "●"
            }
            selectByMouse: false
            selectionColor: "transparent"
            enabled: root.enabled
            
            cursorDelegate: Rectangle {
                color: "transparent"
            }
            
            Keys.onPressed: {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    root.loginRequested()
                    event.accepted = true
                } else if (event.key === Qt.Key_Up || event.key === Qt.Key_Down) {
                    // Forward Up/Down to parent
                    event.accepted = false
                }
            }
        }
    }
}

