import QtQuick 2.0
import SddmComponents 2.0
import "components"
import "utils/ConfigManager.js" as ConfigManager
import "utils/NavigationHandler.js" as NavigationHandler

Rectangle {
    id: mainRect
    focus: true
    
    property string activeSelector: "password" // "password", "user", "session", "power"
    property int activePowerButton: 0 // 0=shutdown, 1=restart, 2=suspend
    property bool capsLockActive: false
    
    // Config properties
    color: config.stringValue("background") || '#000000'
    property string backgroundImage: config.stringValue("backgroundImage") || ""
    
    // Background image
    Image {
        id: backgroundImageComponent
        anchors.fill: parent
        source: mainRect.backgroundImage
        fillMode: Image.PreserveAspectCrop
        visible: mainRect.backgroundImage !== ""
    }
    property int animationDuration: config.intValue("animationDuration") || 200
    property int fadeInDuration: config.intValue("fadeInDuration") || 300
    property int elementSpacing: config.intValue("elementSpacing") || 15
    property bool showPreview: config.boolValue("showSelectorPreview") || false
    property bool showHelpTips: config.boolValue("showHelpTips") || false
    property bool showCapsLockIndicator: config.boolValue("showCapsLockIndicator") || false
    property bool allowEmptyPassword: config.boolValue("allowEmptyPassword") || false
    property bool clearPasswordOnError: config.boolValue("clearPasswordOnError") !== false
    property int passwordFieldOffsetX: config.intValue("passwordFieldOffsetX") || 0
    property int passwordFieldOffsetY: config.intValue("passwordFieldOffsetY") || 0
    property bool showClock: config.boolValue("showClock") || false
    property int clockOffsetX: config.intValue("clockOffsetX") || 0
    property int clockOffsetY: config.intValue("clockOffsetY") || -200
    property real elementOpacity: ConfigManager.getElementOpacity(config)
    
    // Fade-in animation state
    property bool fadeInComplete: false
    Component.onCompleted: {
        fadeInComplete = true
        passwordField.passwordInput.focus = true
    }
    
    // Clock
    Clock {
        id: clock
        showClock: mainRect.showClock
        clockOffsetX: mainRect.clockOffsetX
        clockOffsetY: mainRect.clockOffsetY
        animationDuration: mainRect.animationDuration
        elementOpacity: mainRect.elementOpacity
    }
    
    // Help tips
    HelpTips {
        id: helpTips
        showHelpTips: mainRect.showHelpTips
        fadeInComplete: mainRect.fadeInComplete
        fadeInDuration: mainRect.fadeInDuration
        elementOpacity: mainRect.elementOpacity
    }
    
    // User preview
    SelectorPreview {
        id: userPreview
        previewText: userSelect.selectedUser
        showPreview: mainRect.showPreview
        activeSelector: mainRect.activeSelector
        hideWhenSelector: "user"
        fadeInComplete: mainRect.fadeInComplete
        animationDuration: mainRect.animationDuration
        elementOpacity: mainRect.elementOpacity
        anchors.horizontalCenter: passwordField.horizontalCenter
        anchors.bottom: passwordField.top
        anchors.bottomMargin: config.intValue("selectorPreviewMargin") || 10
    }
    
    // User selector container
    Item {
        id: userSelectContainer
        width: passwordField.width
        height: mainRect.activeSelector === "user" ? (config.intValue("selectorHeight") || 35) : 0
        anchors.horizontalCenter: passwordField.horizontalCenter
        anchors.bottom: passwordField.top
        anchors.bottomMargin: mainRect.elementSpacing
        clip: true
        opacity: mainRect.elementOpacity
        
        Behavior on height {
            NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
        }
        
        UserSelect {
            id: userSelect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            opacity: (mainRect.activeSelector === "user" ? 1 : 0) * mainRect.elementOpacity
            visible: opacity > 0
            
            Behavior on opacity {
                NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
            }
        }
    }
    
    // Caps Lock indicator
    CapsLockIndicator {
        id: capsLockIndicator
        showCapsLockIndicator: mainRect.showCapsLockIndicator
        capsLockActive: mainRect.capsLockActive
        animationDuration: mainRect.animationDuration
        elementOpacity: mainRect.elementOpacity
        anchors.right: passwordField.left
        anchors.rightMargin: 15
        anchors.verticalCenter: passwordField.verticalCenter
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
        elementOpacity: mainRect.elementOpacity
        
        onLoginRequested: {
            var savedPassword = passwordField.passwordText
            
            // Check if empty password is allowed
            if (!mainRect.allowEmptyPassword && savedPassword.length === 0) {
                return
            }
            
            sddm.login(userSelect.selectedUser, savedPassword, sessionSelect.selectedIndex)
            loginErrorTimer.start()
        }
    }
    
    // Login error timer
    Timer {
        id: loginErrorTimer
        interval: config.intValue("loginErrorDelay") || 500
        onTriggered: {
            if (mainRect.activeSelector === "password") {
                passwordField.hasError = true
                if (mainRect.clearPasswordOnError) {
                    passwordField.passwordText = ""
                }
            }
        }
    }
    
    // Session selector container
    Item {
        id: sessionSelectContainer
        width: passwordField.width
        height: mainRect.activeSelector === "session" ? (config.intValue("selectorHeight") || 35) : 0
        anchors.horizontalCenter: passwordField.horizontalCenter
        anchors.top: passwordField.bottom
        anchors.topMargin: mainRect.elementSpacing
        clip: true
        opacity: mainRect.elementOpacity
        
        Behavior on height {
            NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
        }
        
        SessionSelect {
            id: sessionSelect
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            opacity: (mainRect.activeSelector === "session" ? 1 : 0) * mainRect.elementOpacity
            visible: opacity > 0
            
            Behavior on opacity {
                NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
            }
        }
    }
    
    // Session preview
    SelectorPreview {
        id: sessionPreview
        previewText: sessionSelect.selectedSession
        showPreview: mainRect.showPreview
        activeSelector: mainRect.activeSelector
        hideWhenSelector: "session"
        fadeInComplete: mainRect.fadeInComplete
        animationDuration: mainRect.animationDuration
        elementOpacity: mainRect.elementOpacity
        anchors.horizontalCenter: passwordField.horizontalCenter
        anchors.top: passwordField.bottom
        anchors.topMargin: config.intValue("selectorPreviewMargin") || 10
        visible: mainRect.showPreview && mainRect.activeSelector !== "session" && mainRect.activeSelector !== "power" && sessionSelect.selectedSession !== ""
    }
    
    // Power buttons selector container
    Item {
        id: powerButtonContainer
        width: passwordField.width
        height: mainRect.activeSelector === "power" ? (config.intValue("selectorHeight") || 35) : 0
        anchors.horizontalCenter: passwordField.horizontalCenter
        anchors.top: passwordField.bottom
        anchors.topMargin: mainRect.elementSpacing
        clip: true
        opacity: mainRect.elementOpacity
        
        Behavior on height {
            NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
        }
        
        PowerButtons {
            id: powerButtons
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            activeButton: mainRect.activeSelector === "power" ? mainRect.activePowerButton : 0
            fadeInComplete: mainRect.fadeInComplete
            fadeInDuration: mainRect.fadeInDuration
            elementOpacity: mainRect.elementOpacity
            opacity: (mainRect.activeSelector === "power" ? 1 : 0) * mainRect.elementOpacity
            visible: opacity > 0
            
            onActiveButtonChanged: {
                if (mainRect.activeSelector === "power") {
                    mainRect.activePowerButton = powerButtons.activeButton
                }
            }
            
            Behavior on opacity {
                NumberAnimation { duration: mainRect.animationDuration; easing.type: Easing.OutCubic }
            }
        }
    }
    
    // Navigation functions
    function activatePowerButton() {
        if (mainRect.activeSelector === "power" && powerButtons) {
            powerButtons.activateCurrentButton()
        }
    }
    
    function returnToPassword() {
        mainRect.activeSelector = "password"
        passwordField.passwordInput.focus = true
    }
    
    function navigateSelector(selector, direction) {
        return NavigationHandler.navigateSelector(selector, direction, userSelect, sessionSelect)
    }
    
    // Keyboard event handler
    Keys.onPressed: function(event) {
        var handled = false
        
        // Track Caps Lock state
        if (event.key === Qt.Key_CapsLock) {
            mainRect.capsLockActive = !mainRect.capsLockActive
            return
        }
        
        if (event.key === Qt.Key_Up) {
            if (mainRect.activeSelector === "password") {
                mainRect.activeSelector = "user"
                mainRect.focus = true
                handled = true
            } else if (mainRect.activeSelector === "power") {
                mainRect.activeSelector = "session"
                mainRect.focus = true
                handled = true
            } else if (mainRect.activeSelector === "session") {
                returnToPassword()
                handled = true
            } else if (mainRect.activeSelector === "user") {
                handled = false
            } else {
                returnToPassword()
                handled = true
            }
        } else if (event.key === Qt.Key_Down) {
            if (mainRect.activeSelector === "password") {
                mainRect.activeSelector = "session"
                mainRect.focus = true
                handled = true
            } else if (mainRect.activeSelector === "session") {
                mainRect.activeSelector = "power"
                mainRect.activePowerButton = 0
                mainRect.focus = true
                handled = true
            } else if (mainRect.activeSelector === "power") {
                handled = false
            } else {
                returnToPassword()
                handled = true
            }
        } else if (event.key === Qt.Key_Left) {
            if (mainRect.activeSelector === "user") {
                handled = navigateSelector("user", "left")
            } else if (mainRect.activeSelector === "session") {
                handled = navigateSelector("session", "left")
            } else if (mainRect.activeSelector === "power") {
                var newButton = NavigationHandler.navigatePowerButton("left", powerButtons, mainRect.activePowerButton)
                if (newButton !== false) {
                    mainRect.activePowerButton = newButton
                }
                handled = true
            }
        } else if (event.key === Qt.Key_Right) {
            if (mainRect.activeSelector === "user") {
                handled = navigateSelector("user", "right")
            } else if (mainRect.activeSelector === "session") {
                handled = navigateSelector("session", "right")
            } else if (mainRect.activeSelector === "power") {
                var newButton = NavigationHandler.navigatePowerButton("right", powerButtons, mainRect.activePowerButton)
                if (newButton !== false) {
                    mainRect.activePowerButton = newButton
                }
                handled = true
            }
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            if (mainRect.activeSelector === "power") {
                activatePowerButton()
                handled = true
            }
        } else if (event.key === Qt.Key_F10) {
            sddm.suspend()
            handled = true
        } else if (event.key === Qt.Key_F11) {
            sddm.powerOff()
            handled = true
        } else if (event.key === Qt.Key_F12) {
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
