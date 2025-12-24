import QtQuick 2.0
import SddmComponents 2.0
import "components"

Rectangle {
    color: '#000000'
    
    Column {
        anchors.centerIn: parent
        spacing: 15
        
        // User selector
        UserSelect {
            id: userSelect
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        // Password field
        Rectangle {
            width: 250
            height: 35
            color: '#333333'
            radius: 16
            clip: true
            border.color: '#888888'
            border.width: 1
            antialiasing: true
            
            Item {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                clip: true
                
                TextInput {
                    id: passwordInput
                    anchors.fill: parent
                    color: "#c4c4c4"
                    echoMode: TextInput.Password
                    verticalAlignment: TextInput.AlignVCenter
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 16
                    passwordCharacter: "●"
                    selectByMouse: false
                    selectionColor: "transparent"
                    
                    cursorDelegate: Rectangle {
                        color: "transparent"
                    }
                    
                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(userSelect.selectedUser, passwordInput.text, sessionSelect.selectedIndex)
                            event.accepted = true
                        }
                    }
                }
            }
        }
        
        // Session selector
        SessionSelect {
            id: sessionSelect
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    
    Component.onCompleted: {
        passwordInput.focus = true
    }
}