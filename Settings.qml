import QtQuick
import qs.Common
import qs.Modules.Plugins
import qs.Widgets
import Quickshell.Services.UPower

PluginSettings {
    id: root
    pluginId: "powerControl"
    property var profilesOrder: [PowerProfile.PowerSaver, PowerProfile.Balanced, PowerProfile.Performance]
    

    ListModel{
        id: profiles
        ListElement{
            profile: PowerProfile.PowerSaver
            icon: "eco"
            isSkipped: false
        }
        ListElement{
            profile: PowerProfile.Balanced
            icon: "balance"
            isSkipped: false
        }
        ListElement{
            profile: PowerProfile.Balanced
            icon: "bolt"
            isSkipped: false
        }
    }

    StyledText {
        width: parent.width
        text: "Cycle Order"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: "Change the order of power profiles when cycling"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.Bold
        color: Theme.surfaceText
    }
    Component{
        id: profilesDelegate
        StyledText{
            required property string icon
            text:icon
        }
    }
    ListView{
        model: profiles
        delegate: profilesDelegate
    }
    // have the order of the cycler in an array 
    // make a lists with contents in that array
    // have each profile be toggleable on/off to skip them in the order

    // icon color customizer preferably based on the DMS colorscheme
    // also have the icon color be fully custom


    SliderSetting {
        settingKey: "updateInterval"
        label: "Update Speed"
        description: "How often to refresh"
        defaultValue: 60
        minimum: 10
        maximum: 300
        unit: "sec"
    }

    ToggleSetting {
        settingKey: "showInBar"
        label: "Show in Bar"
        description: "Display widget in DankBar"
        defaultValue: true
    }
    
    StringSetting {
        settingKey: "apiKey"
        label: "API Key"
        description: "Your service API key"
        placeholder: "Enter key"
        defaultValue: ""
    }

    SelectionSetting {
        settingKey: "theme"
        label: "Theme"
        description: "Widget appearance"
        options: [
            {label: "Light", value: "light"},
            {label: "Dark", value: "dark"},
            {label: "Auto", value: "auto"}
        ]
        defaultValue: "dark"
    }
}