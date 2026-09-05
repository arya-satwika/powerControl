pragma ComponentBehavior: Bound
import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.Plugins
import qs.Services
import Quickshell.Services.UPower
// import Quickshell.Io

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
    // Process {
    //     id: getprofile
    //     command:["powerprofilesctl", "get" ]
    //     stdout: StdioCollector {
    //         onStreamFinished: root.currentProfile=text.trim()
    //     }
    // }
    // Process {
    //     id: changeprofile
    //     command:["powerprofilesctl", "set", root.changeProfileTo ]
    //     stdout: StdioCollector {
    //         onStreamFinished: root.currentProfile=root.changeProfileTo
    //     }
    // }

    
    Component.onCompleted: {
        // getprofile.running=true
    }


    function cycleProfiles(){
        if (hasPerformance) {
            PowerProfiles.profile = changeProfileTo
        }
    }
    Connections {
        target: PowerProfiles
        // exact signal name depends on the binding — often property change
        function onProfileChanged() {
           console.debug(PowerProfiles.profile.toString(PowerProfile.Balanced))
        //    ToastService.showInfo(PowerProfile.toString(PowerProfile.PowerSaver))
           Log.warn(PowerProfile.Balanced)
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
                        ToastService.showInfo(root.profilesLists.indexOf(PowerProfiles.profile))
                        root.cycleProfiles()
                        Log.warn(PowerProfiles.profile.toString(PowerProfile.Balanced))
                        
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

}