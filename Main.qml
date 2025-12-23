import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    color: '#000000'

    Column {
        anchors.centerIn: parent
        spacing: 15

        // User field
        Rectangle {
            width: 250
            height: 35
            color: '#333333'

            TextInput {
                id: userInput
                anchors.fill: parent
                anchors.margins: 8
                color: '#c4c4c4'
                verticalAlignment: TextInput.AlignVCenter
                text: userModel.lastUser

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        passwordInput.focus = true
                        event.accepted = true
                    }
                }
            }
        }

        // Password field
        Rectangle {
            width: 250
            height: 35
            color: '#333333'

            TextInput {
                id: passwordInput
                anchors.fill: parent
                anchors.margins: 8
                color: "#c4c4c4"
                echoMode: TextInput.Password
                verticalAlignment: TextInput.AlignVCenter

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        sddm.login(userInput.text, passwordInput.text, sessionSelect.selectedIndex)
                        event.accepted = true
                    }
                }
            }
        }

        // Session field
        Column {
            spacing: 3
            width: 250

            Repeater {
                id: sessionSelect
                model: sessionModel
                property int selectedIndex: sessionModel.lastIndex

                delegate: Rectangle {
                    width: 250
                    height: 30
                    color: sessionSelect.selectedIndex === index ? "#3a3a3a" : "transparent"
                    border.color: "#3a3a3a"
                    border.width: sessionSelect.selectedIndex === index ? 1 : 0

                    Text {
                        text: name
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        font.pixelSize: 13
                    }

                    MouseArea {
                        id: sessionMouse
                        anchors.fill: parent
                        onClicked: sessionSelect.selectedIndex = index
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (userInput.text === "") {
            userInput.focus = true
        } else {
            passwordInput.focus = true
        }
    }
}