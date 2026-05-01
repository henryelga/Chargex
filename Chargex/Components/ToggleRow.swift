import SwiftUI

struct ToggleRow: View {
    
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            
            Text(title)
                .foregroundColor(Color.chargexTextPrimary)
                .font(.subheadline)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Color.chargexPrimary)
        }
    }
}

struct PickerRow<T: Hashable>: View {
    
    let title: String
    @Binding var selection: T
    let options: [(String, T)]
    
    var body: some View {
        HStack {
            
            Text(title)
                .foregroundColor(Color.chargexTextPrimary)
                .font(.subheadline)
            
            Spacer()
            
            Menu {
                ForEach(options, id: \.1) { label, value in
                    Button(label) {
                        selection = value
                    }
                }
            } label: {
                Text(options.first(where: { $0.1 == selection })?.0 ?? "")
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(Color.chargexTextPrimary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.chargexBackground.opacity(0.6))
                    .clipShape(Capsule())
            }
        }
    }
}
