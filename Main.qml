import QtQuick 2.0
import SddmComponents 2.0
import "components"

Rectangle {
    id: mainRect
    focus: true
    
    property string activeSelector: "password" // "password", "user", "session"
    
    // Config properties
    color: config.stringValue("background") || '#000000'
    property int animationDuration: config.intValue("animationDuration") || 200
    property int elementSpacing: config.intValue("elementSpacing") || 15
    
    // User selector
    Item {
        id: userSelectContainer
        width: 230
        height: mainRect.activeSelector === "user" ? 35 : 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: passwordField.top
        anchors.bottomMargin: mainRect.elementSpacing
        clip: true
        
        Behavior on height {
            NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
        }
        
        UserSelect {
            id: userSelect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            opacity: mainRect.activeSelector === "user" ? 1 : 0
            visible: opacity > 0
            
            Behavior on opacity {
                NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
            }
        }
    }
    
    // Password field
    PasswordField {
        id: passwordField
        anchors.centerIn: parent
        enabled: mainRect.activeSelector === "password"
        
        onLoginRequested: {
            sddm.login(userSelect.selectedUser, passwordField.passwordText, sessionSelect.selectedIndex)
        }
    }
    
    // Session selector
    Item {
        id: sessionSelectContainer
        width: 230
        height: mainRect.activeSelector === "session" ? 35 : 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: passwordField.bottom
        anchors.topMargin: mainRect.elementSpacing
        clip: true
        
        Behavior on height {
            NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
        }
        
        SessionSelect {
            id: sessionSelect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            opacity: mainRect.activeSelector === "session" ? 1 : 0
            visible: opacity > 0
            
            Behavior on opacity {
                NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
            }
        }
    }
    
    // Power buttons at bottom center
    PowerButtons {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
    }
    
    function returnToPassword() {
        mainRect.activeSelector = "password"
        passwordField.passwordInput.focus = true
    }
    
    function navigateSelector(selector, direction) {
        var count = selector === "user" ? userSelect.userCount : sessionSelect.sessionCount
        if (count === 0) return false
        
        var currentIndex = selector === "user" ? userSelect.selectedIndex : sessionSelect.selectedIndex
        
        if (direction === "left") {
            currentIndex = currentIndex > 0 ? currentIndex - 1 : count - 1
        } else {
            currentIndex = currentIndex < count - 1 ? currentIndex + 1 : 0
        }
        
        if (selector === "user") {
            userSelect.selectedIndex = currentIndex
        } else {
            sessionSelect.selectedIndex = currentIndex
        }
        return true
    }
    
    Keys.onPressed: {
        var handled = false
        
        if (event.key === Qt.Key_Up) {
            if (mainRect.activeSelector === "password") {
                // Show user selector
                mainRect.activeSelector = "user"
                mainRect.focus = true
                handled = true
            } else {
                // Return to password from any selector
                returnToPassword()
                handled = true
            }
        } else if (event.key === Qt.Key_Down) {
            if (mainRect.activeSelector === "password") {
                // Show session selector
                mainRect.activeSelector = "session"
                mainRect.focus = true
                handled = true
            } else {
                // Return to password from any selector
                returnToPassword()
                handled = true
            }
        } else if (event.key === Qt.Key_Left) {
            // Navigate left in active selector
            if (mainRect.activeSelector === "user") {
                handled = navigateSelector("user", "left")
            } else if (mainRect.activeSelector === "session") {
                handled = navigateSelector("session", "left")
            }
        } else if (event.key === Qt.Key_Right) {
            // Navigate right in active selector
            if (mainRect.activeSelector === "user") {
                handled = navigateSelector("user", "right")
            } else if (mainRect.activeSelector === "session") {
                handled = navigateSelector("session", "right")
            }
        }
        
        if (handled) {
            event.accepted = true
        }
    }
    
    Component.onCompleted: {
        passwordField.passwordInput.focus = true
    }
}