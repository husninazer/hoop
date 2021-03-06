import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

import QtQuick.Controls.Material 2.0




Page {
    id: window
    visible: true
anchors.fill: parent





    property bool _CON: true

    property bool _IS_LOGGED_IN: true


        BusyIndicator {
            id: busyIndicatorLoginPage
            visible: false
            anchors.centerIn: parent
            z: 100
        }


        Pane {
            id: paneLogin
            width: parent.width

            Column {
                width: parent.width
                topPadding: 20
                spacing: 20


                Image {
                    id: logoImage
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width / 2
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/Images/logo.png"
                }

                Label {
                    text: 'Login'
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                TextField {
                    id: txtLoginUserName
                    width: parent.width - 80
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText: 'Username'

                }

                TextField {
                    id: txtLoginPassword
                    width: parent.width - 80
                    anchors.horizontalCenter: parent.horizontalCenter
                    echoMode: TextInput.Password
                    placeholderText: 'Password'

                }


                Button {
                    id: btnLogin
                    text: 'Login'
                    width: parent.width - 80
                    anchors.horizontalCenter: parent.horizontalCenter
                    highlighted: true

                    ToolTip.timeout: 5000

                    onClicked: {


                        if(txtLoginUserName.text === '' || txtLoginPassword.text === '') {
                            btnLogin.ToolTip.text = 'Fill in username/ password to login'
                            btnLogin.ToolTip.visible = true
                            return
                        }


                        busyIndicatorLoginPage.visible = true
                        stackView.push("qrc:/Home/HomeComponent.qml")
                    }
                }
            }
        }

        Pane {
            id: paneRegister
            anchors.fill: parent
            visible: false

            BusyIndicator {
                id: busyIndicatorRegisterPage
                visible: false
                z: 100
                anchors.centerIn: parent
            }


            Flickable {
                anchors.fill: parent
                contentHeight: colList.height + 100
                Column {
                    id: colList
                    width: parent.width
                    topPadding: 10
                    spacing: 10

                    Label {
                        text: 'Register'
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 20
                    }


                    TextField {
                        id: txtUserName
                        placeholderText: 'Username'
                        width: parent.width - 70
                        anchors.horizontalCenter: parent.horizontalCenter

                    }


                    TextField {
                        id: txtPassword
                        placeholderText: 'Password'
                        echoMode: TextInput.Password
                        width: parent.width - 70
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    TextField {

                        id: txtConfirmPassword
                        placeholderText: 'Confirm Password'
                        echoMode: TextInput.Password
                        width: parent.width - 70
                        anchors.horizontalCenter: parent.horizontalCenter



                    }


                    TextField {

                        id: txtCountry
                        placeholderText: 'Country'
                        width: parent.width - 70
                        anchors.horizontalCenter: parent.horizontalCenter



                    }

                    TextField {

                        id: txtPassport
                        placeholderText: 'Passport / ID no.'
                        echoMode: TextInput.Password
                        width: parent.width - 70
                        anchors.horizontalCenter: parent.horizontalCenter


                    }






                    Button {
                        id: btnRegister
                        highlighted: true
                        width: parent.width - 70
                        text: 'Register'
                        anchors.horizontalCenter: parent.horizontalCenter

                        ToolTip.timeout: 5000

                        onClicked: {


                            if (txtPassword.text !== txtConfirmPassword.text) {
                                this.ToolTip.text = 'Passwords are not matching'
                                this.ToolTip.visible = true
                                return
                            }
                            if(txtUserName.text == '' ) {
                                this.ToolTip.text = 'Please fill in all the fields'
                                this.ToolTip.visible = true
                                return
                            }
                            if(txtPassword.text.length < 4) {
                                this.ToolTip.text = 'Password should be atleast 4 Characters'
                                this.ToolTip.visible = true
                                return
                            }

                            if(_SELECTED_BANKS.length == 0) {
                                this.ToolTip.text = 'Please select at least one Bank'
                                this.ToolTip.visible = true
                                return
                            }

                            _SELECTED_BANKS = removeDuplicates(_SELECTED_BANKS);


                            busyIndicatorRegisterPage.visible = true

                            isUserUnique(txtUserName.text, function(result) {
                                if(result){
                                    registerUserDrupal(function(data) {
                                        busyIndicatorRegisterPage.visible = false

                                        if(data === 'error') {
                                            btnRegister.ToolTip.text = 'Check Internet Connection'
                                            btnRegister.ToolTip.visible = true
                                            return
                                        }

                                        // clear all text
                                        txtConfirmPassword.text = ''
                                        txtPassword.text = ''
                                        txtUserName.text = ''

                                        //

                                        paneRegister.visible = false
                                        paneLogin.visible = true

                                    })
                                }
                                else {
                                    busyIndicatorRegisterPage.visible = false
                                    btnRegister.ToolTip.text = 'Username already registered'
                                    btnRegister.ToolTip.visible = true
                                    return
                                }
                            })


                        }
                    }


                }
            }
        }

        footer: TabBar {
            TabButton {
                id: tabButtonLogin
                text: 'Login'
                onClicked: {
                    paneRegister.visible = false
                    paneLogin.visible = true
                }
            }

            TabButton {
                text: 'Register'
                onClicked: {
                    paneRegister.visible = true
                    paneLogin.visible = false

                }
            }
        }

    }

