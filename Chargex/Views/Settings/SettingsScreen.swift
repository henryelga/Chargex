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
        NavigationStack {
            ScrollView {
                
                VStack(spacing: 16) {
                    
                    // MARK: - Appearance
                    settingsCard(title: "Appearance") {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                            .tint(.chargexPrimary)
                    }
                    
                    // MARK: - Text Size
                    settingsCard(title: "Text Size") {
                        Picker("Font Size", selection: $isLargeText) {
                            Text("Regular").tag(false)
                            Text("Large").tag(true)
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    // MARK: - Notifications
                    settingsCard(title: "Charging Notifications") {
                        
                        Toggle("Enable Notifications", isOn: $notificationsEnabled)
                            .tint(.chargexPrimary)
                            .onChange(of: notificationsEnabled) { _, newValue in
                                if newValue {
                                    requestNotificationPermission { granted in
                                        notificationsEnabled = granted
                                    }
                                }
                            }
                        
                        if notificationsEnabled {
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Button {
                                    withAnimation {
                                        showPicker.toggle()
                                    }
                                } label: {
                                    HStack {
                                        Text("Notify after")
                                            .foregroundColor(.primary)
                                        
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
                                    .frame(height: 140)
                                    .clipped()
                                }
                            }
                            .transition(.opacity)
                        }
                    }
                }
                .padding()
            }
            .background(Color.chargexBackground)
            .navigationTitle("Settings")
        }
    }
    
    // MARK: - Reusable Card
    private func settingsCard<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(title)
                .font(.headline)
                .foregroundColor(.chargexTextPrimary)
            
            content()
        }
        .padding()
        .background(Color.chargexCard)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
    }
}
