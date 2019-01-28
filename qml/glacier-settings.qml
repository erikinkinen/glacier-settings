/*
 * Copyright (C) 2017 Chupligin Sergey <neochapay@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

import QtQuick 2.6
import QtQuick.Window 2.1

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import org.nemomobile.glacier.settings 1.0
import org.nemomobile.systemsettings 1.0

import "components"

ApplicationWindow{
    id: main

    SettingsModel{
        id: settingsModel
        path: "/usr/share/glacier-settings/plugins/"
    }

    SettingsService{
        id: setingService

        onOpenSettingsPage: {
            pageStack.push(Qt.resolvedUrl("plugins/"+plugin+"/"+plugin+".qml"))
            main.raise()
        }
    }

    initialPage: Page{
        id: mainPage
        headerTools: HeaderToolsLayout {
            id: tools
            title: qsTr("Settings")
        }
        Flickable{
            id: mainArea
            height: parent.height-tools.height
            width: parent.width

            contentHeight: content.height

            Column {
                id: content
                width: parent.width
                spacing: size.dp(20)

                QuickSettings{
                    id: quickSettings
                }

                Repeater {
                    id: view

                    model: settingsModel
                    delegate: Rectangle {
                        id: settingsListDelegate
                        height: sectionHeading.height+flow.height
                        width: mainArea.width
                        color: Theme.backgroundColor

                        Rectangle {
                            id: sectionHeading
                            width: parent.width
                            height: Theme.itemHeightMedium
                            color: Theme.backgroundColor

                            Text {
                                id: sectionText
                                text: title
                                font.capitalization: Font.AllUppercase
                                font.pixelSize: Theme.fontSizeSmall
                                color: Theme.textColor
                                anchors{
                                    left: parent.left
                                    leftMargin: Theme.itemSpacingSmall
                                    verticalCenter: parent.verticalCenter
                                }
                            }

                            Rectangle{
                                id: line
                                height: size.ratio(1)
                                color: Theme.textColor
                                width: content.width-sectionText.width-Theme.itemHeightExtraSmall
                                anchors{
                                    left: sectionText.right
                                    leftMargin: Theme.itemSpacingSmall
                                    verticalCenter: sectionText.verticalCenter
                                }
                            }
                        }

                        Flow{
                            id: flow
                            width: parent.width
                            anchors.top: sectionHeading.bottom
                            Repeater{
                                id: list
                                width: parent.width
                                height: isUiLandscape ?
                                            Theme.itemHeightMedium*Math.ceil(items.length/2) :
                                            Theme.itemHeightMedium*items.length
                                model: items

                                delegate: ListViewItemWithActions {
                                    height: Theme.itemHeightMedium
                                    width: isUiLandscape ? parent.width/2 : parent.width
                                    label: modelData.title
                                    icon: "/usr/share/glacier-settings/qml/plugins/"+modelData.path+"/"+modelData.path+".svg"
                                    onClicked:{
                                        pageStack.push(Qt.resolvedUrl("plugins/"+modelData.path+"/"+modelData.path+".qml"))
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
