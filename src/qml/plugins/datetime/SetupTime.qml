/*
 * Copyright (C) 2021 Chupligin Sergey <neochapay@gmail.com>
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

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0

import org.nemomobile.systemsettings 1.0

import org.nemomobile.glacier.settings 1.0

import "../../components"

Page {
    id: dataTimeSetupTime

    headerTools: HeaderToolsLayout {
        showBackButton: true;
        title: qsTr("Setup time")
    }

    DateTimeSettings{
        id: dateTimeSettings
    }

    SettingsColumn {
        id: dataSettingsColumn
        anchors.fill: parent

        Item {
            id: timeSelect
            width: parent.width
            height: Theme.itemHeightLarge

            TextField{
                id: hours
                text: Qt.formatDateTime(new Date(), "HH:mm");
                width: Theme.itemWidthExtraSmall
                horizontalAlignment: TextInput.AlignRight
                maximumLength: 2
                inputMethodHints: Qt.ImhTime

                anchors{
                    verticalCenter: parent.verticalCenter
                    right: twoDots.left
                }
            }

            Label{
                id: twoDots
                text: ":"
                anchors{
                    centerIn: parent
                }
            }

            TextField{
                id: minutes
                text: Qt.formatDateTime(new Date(), "mm");
                width: Theme.itemWidthExtraSmall
                horizontalAlignment: TextInput.AlignLeft
                maximumLength: 2
                inputMethodHints: Qt.ImhDigitsOnly

                anchors{
                    verticalCenter: parent.verticalCenter
                    left: twoDots.right
                }
            }
        }
    }
}
