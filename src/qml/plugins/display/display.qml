/*
 * Copyright (C) 2017-2021 Chupligin Sergey <neochapay@gmail.com>
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

import org.nemomobile.systemsettings 1.0

import "../../components"

Page {
    id: displaySettingsPage

    headerTools: HeaderToolsLayout { showBackButton: true; title: qsTr("Display settings")}

    DisplaySettings{
        id: displaySettings
    }

    ScrollDecorator{
        id: displayScroolDecorator
        flickable: displaySettingsColumn
    }

    ListModel{
        id: orientationModel
        ListElement{
            name: qsTr("Dynamic")
        }
        ListElement{
            name: qsTr("Portrait")
        }
        ListElement{
            name: qsTr("Landscape")
        }
    }

    ListModel {
        id: dimTimeoutModel
        ListElement {
            name: qsTr("15 sec")
            value: 15
        }
        ListElement {
            name: qsTr("30 sec")
            value: 30
        }
        ListElement {
            name: qsTr("1 min")
            value: 60
        }
        ListElement {
            name: qsTr("2 min")
            value: 120
        }
        ListElement {
            name: qsTr("5 min")
            value: 300
        }
        ListElement {
            name: qsTr("10 min")
            value: 600
        }
    }


    SettingsColumn{
        id: displaySettingsColumn
        spacing: Theme.itemSpacingLarge

        Label{
            id: brightnessLabel
            text: qsTr("Brightness");
        }

        CheckBox{
            id: autoBrightnessCheck
            text: qsTr("Auto brightness");
            checked: displaySettings.autoBrightnessEnabled
            onClicked: displaySettings.autoBrightnessEnabled = checked
        }


        Slider{
            id: brightnessSlider
            width: parent.width
            visible: ! displaySettings.autoBrightnessEnabled

            minimumValue: 0
            maximumValue: displaySettings.maximumBrightness

            value: displaySettings.brightness

            stepSize: 1
            onValueChanged: {
                displaySettings.brightness = value
            }
            enabled: !displaySettings.autoBrightnessEnabled
        }

        GlacierRoller {
            id: dsisplaySleepRoller
            width: parent.width

            clip: true
            model: dimTimeoutModel
            label: qsTr("Display sleep timeout")

            delegate: GlacierRollerItem{
                Text{
                    height: dsisplaySleepRoller.itemHeight
                    verticalAlignment: Text.AlignVCenter
                    text: name
                    color: Theme.textColor
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: (dsisplaySleepRoller.activated && dsisplaySleepRoller.currentIndex === index)
                }

                Component.onCompleted: {
                    if(value == displaySettings.dimTimeout) {
                        dsisplaySleepRoller.currentIndex =  index
                    }
                }
            }

            onCurrentIndexChanged: {
                displaySettings.dimTimeout = dimTimeoutModel.get(dsisplaySleepRoller.currentIndex).value
            }
        }


        GlacierRoller {
            id: orientationLockRoller
            width: parent.width

            clip: true
            model: orientationModel
            label: qsTr("Orientation")

            delegate: GlacierRollerItem{
                Text{
                    height: orientationLockRoller.itemHeight
                    verticalAlignment: Text.AlignVCenter
                    text: name
                    color: Theme.textColor
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: (orientationLockRoller.activated && orientationLockRoller.currentIndex === index)
                }

                Component.onCompleted: {
                    if(name.toLowerCase() == displaySettings.orientationLock) {
                        orientationLockRoller.currentIndex =  index
                    }
                }
            }

            onCurrentIndexChanged: {
                displaySettings.orientationLock = orientationModel.get(orientationLockRoller.currentIndex).name.toLowerCase()
            }
        }
    }
}

