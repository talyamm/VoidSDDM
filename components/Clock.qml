import QtQuick 2.0

Text {
    id: root
    
    property bool showClock: false
    property int clockOffsetX: 0
    property int clockOffsetY: 0
    property int animationDuration: 200
    property real elementOpacity: 1.0
    
    anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
    anchors.verticalCenter: parent ? parent.verticalCenter : undefined
    anchors.horizontalCenterOffset: root.clockOffsetX
    anchors.verticalCenterOffset: root.clockOffsetY
    
    visible: root.showClock
    color: config.stringValue("clockColor") || config.stringValue("textColor") || "#c4c4c4"
    font.pixelSize: config.intValue("clockFontSize") || 24
    font.family: config.stringValue("clockFontFamily") || config.stringValue("fontFamily") || "JetBrains Mono Nerd Font"
    opacity: (root.visible ? 1 : 0) * root.elementOpacity
    
    property string clockFormat: config.stringValue("clockFormat") || "%H:%M"
    property string currentTime: formatTime(clockFormat)
    
    function formatTime(format) {
        var date = new Date()
        var hours24 = date.getHours()
        var hours12 = hours24 % 12
        if (hours12 === 0) hours12 = 12
        var minutes = date.getMinutes()
        var seconds = date.getSeconds()
        
        var formatted = format
        // Replace in order: uppercase first (with padding), then lowercase (without padding)
        // %H - 24 hours with padding (09)
        formatted = formatted.replace(/%H/g, (hours24 < 10 ? "0" : "") + hours24)
        // %h - 12 hours without padding (9)
        formatted = formatted.replace(/%h/g, hours12.toString())
        // %M - minutes with padding (09)
        formatted = formatted.replace(/%M/g, (minutes < 10 ? "0" : "") + minutes)
        // %m - minutes without padding (9)
        formatted = formatted.replace(/%m/g, minutes.toString())
        // %S - seconds with padding (09)
        formatted = formatted.replace(/%S/g, (seconds < 10 ? "0" : "") + seconds)
        // %s - seconds without padding (3)
        formatted = formatted.replace(/%s/g, seconds.toString())
        
        return formatted
    }
    
    text: root.currentTime
    
    Timer {
        id: updateTimer
        interval: 1000
        running: root.showClock
        repeat: true
        onTriggered: {
            root.currentTime = root.formatTime(root.clockFormat)
        }
    }
    
    Component.onCompleted: {
        root.currentTime = root.formatTime(root.clockFormat)
    }
    
    Behavior on opacity {
        NumberAnimation { duration: root.animationDuration; easing.type: Easing.OutCubic }
    }
}

