import QtQuick
import qs.Common
import qs.Modules.Plugins
import qs.Widgets

PluginSettings {
    id: root
    pluginId: "powerControl"

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