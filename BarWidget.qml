pragma ComponentBehavior: Bound
import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.Plugins
import qs.Services
import Quickshell.Services.UPower

PluginComponent {
    id: root

    readonly property var icons: ({
        "PowerSaver":  "eco",
        "Balanced"   :   "balance",
        "Performance":  "bolt"
        })
    readonly property var profilesLists: [PowerProfile.PowerSaver, PowerProfile.Balanced, PowerProfile.Performance]
    property var changeProfileTo: profilesLists[(profilesLists.indexOf(PowerProfiles.profile)+1)%3]
    property bool hasPerformance: PowerProfiles.hasPerformanceProfile
    property string currentIcon: icons[PowerProfile.toString(PowerProfiles.profile)]

    
    function cycleProfiles(){
        if (hasPerformance) {
            PowerProfiles.profile = changeProfileTo
        }
    }

    verticalBarPill: Component {
        Column{
            DankIcon{
                name: root.currentIcon
                size: Theme.fontSizeXLarge
                color: Theme.secondary
                implicitHeight: Theme.fontSizeXLarge
                filled: true
                MouseArea{
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill:parent
                    onClicked: {
                        root.cycleProfiles()
                    }
                    hoverEnabled: true
                    preventStealing: true
                }
            }

        }
    }
    horizontalBarPill: Component {
        Row{
            DankIcon{
                name: root.currentIcon
                size: Theme.fontSizeXLarge
                implicitHeight: Theme.fontSizeXLarge
                color: Theme.secondary
                filled: true
                MouseArea{
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill:parent
                    onClicked: {
                        root.cycleProfiles()
                    }
                    hoverEnabled: true
                    preventStealing: true
                }
            }

        }
    }
    popoutContent: Component {
        PopoutComponent {
            id: popoutColumn

            headerText: "Emoji Picker"
            detailsText: "Click an emoji to copy it"
            showCloseButton: true

            

            
            // function initModel(){
            //     profilesOrder.clear();
            //     for (const profile of popoutColumn.order ) {
            //         profilesOrder.append({
            //             "name": profile
            //         })
            //     }
            // }
            property var profilesOrder: [
                    "power-saver", "balanced", "performance"
                ]
            Item {
                width: parent.width
                implicitHeight: root.popoutHeight - popoutColumn.headerHeight -
                               popoutColumn.detailsHeight - Theme.spacingXL
                ListModel{
                id: profilesOrder
                    ListElement{
                        profileName: "power-saver"
                    }
                    ListElement{
                        profileName: "balanced"
                    }
                }
                
                

                DankListView {
                    id: pePe
                    anchors.fill: parent
                    model: popoutColumn.profilesOrder
                    

                    delegate: StyledRect {
                        StyledText {
                            anchors.centerIn: parent
                            text: modelData
                            font.pixelSize: Theme.fontSizeXLarge
                        }
                        width: pePe.width
                        height: 45
                        radius: Theme.cornerRadius
                        color: Theme.surfaceContainerHigh

                    }
                        
                }
            }
        }
    }

    popoutWidth: 400
    popoutHeight: 500

}