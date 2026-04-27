import SwiftUI

struct SettingsScreen: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isLargeText") private var isLargeText = false
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @AppStorage("notificationDelay") private var notificationDelay = 10
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section(header: Text("Text Size")) {
                    Picker("Font Size", selection: $isLargeText) {
                        Text("Regular").tag(false)
                        Text("Large").tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Charging Notifications")) {
                                    
                                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                                    
                                    if notificationsEnabled {
                                        Stepper(value: $notificationDelay, in: 1...120) {
                                            Text("Notify after \(notificationDelay) minutes")
                                        }
                                    }
                                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsScreen()
}
