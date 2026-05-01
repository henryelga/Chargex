import SwiftUI

struct FilterSheet: View {
    
    @ObservedObject var controller: MapController
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            
            // MARK: - Background
            Color.chargexBackground
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    header
                    
                    filterCard {
                        ToggleRow(
                            title: "Free Only",
                            isOn: $controller.showFreeOnly
                        )
                    }
                    
                    filterCard {
                        PickerRow(
                            title: "Socket Type",
                            selection: $controller.selectedSocketType,
                            options: [
                                ("None", SocketType.none),
                                ("Type 2", SocketType.type2),
                                ("CHAdeMO", SocketType.chademo),
                                ("Type 2 Combo", SocketType.type2Combo)
                            ]
                        )
                    }
                    
                    filterCard {
                        ToggleRow(
                            title: "Fast Charger (≥50kW)",
                            isOn: $controller.requireFast
                        )
                    }
                    
                    filterCard {
                        PickerRow(
                            title: "Operator",
                            selection: $controller.selectedOperator,
                            options: controller.getUniqueOperators().map { ($0, $0) }
                        )
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
        }
    }
    
    // MARK: - HEADER
    private var header: some View {
        HStack {
            
            Text("Filters")
                .padding(.top, 16)
                .padding(.leading, 16)
                .font(.title3.weight(.semibold))
                .foregroundColor(Color.chargexTextPrimary)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color.chargexTextPrimary)
                    .padding(10)
                    .background(Color.chargexCard)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(
                                colorScheme == .dark
                                ? Color.white.opacity(0.15)
                                : Color.black.opacity(0.2),
                                lineWidth: 1
                            )
                    )
            }
        }
        .padding(.bottom, 4)
    }
    
    // MARK: - CARD WRAPPER
    private func filterCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            content()
        }
        .padding()
        .background(Color.chargexCard)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(
                    colorScheme == .dark
                    ? Color.white.opacity(0.08)
                    : Color.black.opacity(0.06),
                    lineWidth: 1
                )
        )
        .shadow(color: .black.opacity(0.05),
                radius: 10, x: 0, y: 5)
    }
}
