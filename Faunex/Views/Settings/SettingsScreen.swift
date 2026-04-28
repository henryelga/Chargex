import SwiftUI
import UserNotifications

struct SettingsScreen: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isLargeText") private var isLargeText = false
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @AppStorage("notificationDelay") private var notificationDelay = 20
    @State private var showPicker = false
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
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
                    .onChange(of: notificationsEnabled) { oldValue, newValue in
                        if newValue {
                            requestNotificationPermission { granted in
                                notificationsEnabled = granted
                            }
                        }
                    }
                                    
                    if notificationsEnabled {
                        
                        VStack(spacing: 8) {
                            
                            Button {
                                withAnimation {
                                    showPicker.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("Notify after")
                                    
                                    Spacer()
                                    
                                    Text("\(notificationDelay) min")
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            if showPicker {
                                Picker("Minutes", selection: $notificationDelay) {
                                    ForEach(1...120, id: \.self) { minute in
                                        Text("\(minute) min").tag(minute)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 150)
                                .clipped()
                            }
                        }
                    }                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsScreen()
}
