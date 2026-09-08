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
    property PowerProfile currentProfile: PowerProfiles.profile
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

}