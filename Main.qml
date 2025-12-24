import QtQuick 2.0
import SddmComponents 2.0
import "components"

Rectangle {
    id: mainRect
    focus: true
    
    property string activeSelector: "password" // "password", "user", "session", "power"
    property int activePowerButton: 0 // 0=shutdown, 1=restart, 2=suspend
    
    // Help tips (top left)
    Text {
        id: helpTips
        visible: mainRect.showHelpTips
        text: "F10 - suspend\nF11 - shutdown\nF12 - restart"
        color: config.stringValue("helpTipsColor") || "#666666"
        font.pixelSize: config.intValue("helpTipsFontSize") || 11
        font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        opacity: mainRect.fadeInComplete ? 1 : 0
        
        Behavior on opacity {
            NumberAnimation { duration: mainRect.fadeInDuration; easing.type: Easing.OutCubic }
        }
    }
    
    // Config properties
    color: config.stringValue("background") || '#000000'
    property int animationDuration: config.intValue("animationDuration") || 200
    property int fadeInDuration: config.intValue("fadeInDuration") || 300
    property int elementSpacing: config.intValue("elementSpacing") || 15
    property bool showPreview: config.boolValue("showSelectorPreview") || false
    property bool showHelpTips: config.boolValue("showHelpTips") || false
    property bool showCapsLockIndicator: config.boolValue("showCapsLockIndicator") || false
    property bool allowEmptyPassword: config.boolValue("allowEmptyPassword") || false
    property int passwordFieldOffsetX: config.intValue("passwordFieldOffsetX") || 0
    property int passwordFieldOffsetY: config.intValue("passwordFieldOffsetY") || 0
    
    // Fade-in animation state
    property bool fadeInComplete: false
    Component.onCompleted: {
        fadeInComplete = true
        passwordField.passwordInput.focus = true
    }
    
    // User preview text (above password field)
    Text {
        id: userPreview
        text: userSelect.selectedUser
        color: config.stringValue("selectorPreviewColor") || "#666666"
        font.pixelSize: config.intValue("selectorPreviewFontSize") || 11
        font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
        anchors.horizontalCenter: passwordField.horizontalCenter
        anchors.bottom: passwordField.top
        anchors.bottomMargin: config.intValue("selectorPreviewMargin") || 10
        visible: mainRect.showPreview && mainRect.activeSelector !== "user" && userSelect.selectedUser !== ""
        opacity: (visible && mainRect.fadeInComplete) ? 1 : 0
        
        Behavior on opacity {
            NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
        }
    }
    
    // User selector
    Item {
        id: userSelectContainer
        width: passwordField.width
        height: mainRect.activeSelector === "user" ? (config.intValue("selectorHeight") || 35) : 0
        anchors.horizontalCenter: passwordField.horizontalCenter
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
    
    // Caps Lock state tracking
    property bool capsLockActive: false
    
    // Caps Lock indicator
    Text {
        id: capsLockIndicator
        visible: mainRect.showCapsLockIndicator && mainRect.capsLockActive
        text: "CAPS LOCK"
        color: config.stringValue("capsLockIndicatorColor") || "#ffaa00"
        font.pixelSize: config.intValue("capsLockIndicatorFontSize") || 12
        font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
        anchors.right: passwordField.left
        anchors.rightMargin: 15
        anchors.verticalCenter: passwordField.verticalCenter
        opacity: visible ? 1 : 0
        
        Behavior on opacity {
            NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
        }
    }
    
    // Password field
    PasswordField {
        id: passwordField
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: mainRect.passwordFieldOffsetX
        anchors.verticalCenterOffset: mainRect.passwordFieldOffsetY
        enabled: mainRect.activeSelector === "password"
        fadeInComplete: mainRect.fadeInComplete
        fadeInDuration: mainRect.fadeInDuration
        
        onLoginRequested: {
            var savedPassword = passwordField.passwordText
            
            // Check if empty password is allowed
            if (!mainRect.allowEmptyPassword && savedPassword.length === 0) {
                // Don't attempt login with empty password
                return
            }
            
            passwordField.passwordText = "" // Clear password field
            sddm.login(userSelect.selectedUser, savedPassword, sessionSelect.selectedIndex)
            
            // Check for login error after a short delay
            loginErrorTimer.start()
        }
    }
    
    Timer {
        id: loginErrorTimer
        interval: config.intValue("loginErrorDelay") || 500 // Delay to check if login failed
        onTriggered: {
            // If we're still on the login screen, assume login failed
            if (mainRect.activeSelector === "password") {
                passwordField.hasError = true
            }
        }
    }
    
    // Session selector
    Item {
        id: sessionSelectContainer
        width: passwordField.width
        height: mainRect.activeSelector === "session" ? (config.intValue("selectorHeight") || 35) : 0
        anchors.horizontalCenter: passwordField.horizontalCenter
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
    
    // Session preview text (below password field)
    Text {
        id: sessionPreview
        text: sessionSelect.selectedSession
        color: config.stringValue("selectorPreviewColor") || "#666666"
        font.pixelSize: config.intValue("selectorPreviewFontSize") || 11
        font.family: config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
        anchors.horizontalCenter: passwordField.horizontalCenter
        anchors.top: passwordField.bottom
        anchors.topMargin: config.intValue("selectorPreviewMargin") || 10
        visible: mainRect.showPreview && mainRect.activeSelector !== "session" && sessionSelect.selectedSession !== ""
        opacity: (visible && mainRect.fadeInComplete) ? 1 : 0
        
        Behavior on opacity {
            NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
        }
    }
    
    // Power buttons at bottom center
    PowerButtons {
        id: powerButtons
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: config.intValue("powerButtonBottomMargin") || 30
        activeButton: mainRect.activeSelector === "power" ? mainRect.activePowerButton : -1
        fadeInComplete: mainRect.fadeInComplete
        fadeInDuration: mainRect.fadeInDuration
    }
    
    function activatePowerButton() {
        if (mainRect.activePowerButton === 0) {
            sddm.powerOff()
        } else if (mainRect.activePowerButton === 1) {
            sddm.reboot()
        } else if (mainRect.activePowerButton === 2) {
            sddm.suspend()
        }
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
    
    Keys.onPressed: function(event) {
        var handled = false
        
        // Track Caps Lock state
        if (event.key === Qt.Key_CapsLock) {
            mainRect.capsLockActive = !mainRect.capsLockActive
            return
        }
        
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
            } else if (mainRect.activeSelector === "session") {
                // Go to power buttons
                mainRect.activeSelector = "power"
                mainRect.activePowerButton = 0
                mainRect.focus = true
                handled = true
            } else if (mainRect.activeSelector === "power") {
                // Return to session from power
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
            } else if (mainRect.activeSelector === "power") {
                // Navigate left in power buttons
                mainRect.activePowerButton = mainRect.activePowerButton > 0 ? mainRect.activePowerButton - 1 : 2
                handled = true
            }
        } else if (event.key === Qt.Key_Right) {
            // Navigate right in active selector
            if (mainRect.activeSelector === "user") {
                handled = navigateSelector("user", "right")
            } else if (mainRect.activeSelector === "session") {
                handled = navigateSelector("session", "right")
            } else if (mainRect.activeSelector === "power") {
                // Navigate right in power buttons
                mainRect.activePowerButton = mainRect.activePowerButton < 2 ? mainRect.activePowerButton + 1 : 0
                handled = true
            }
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            // Activate power button
            if (mainRect.activeSelector === "power") {
                activatePowerButton()
                handled = true
            }
        } else if (event.key === Qt.Key_F10) {
            // Suspend
            sddm.suspend()
            handled = true
        } else if (event.key === Qt.Key_F11) {
            // Shutdown
            sddm.powerOff()
            handled = true
        } else if (event.key === Qt.Key_F12) {
            // Restart
            sddm.reboot()
            handled = true
        }
        
        if (handled) {
            event.accepted = true
        }
    }
    
    // Hide cursor if configured
    Loader {
        active: config.boolValue("showCursor") === false
        anchors.fill: parent
        sourceComponent: MouseArea {
            enabled: false
            cursorShape: Qt.BlankCursor
            acceptedButtons: Qt.NoButton
        }
    }
}