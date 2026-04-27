import SwiftUI
import MapKit

struct MapScreen: View {
    
    @StateObject private var controller = MapController()
    
    @State private var selectedStation: ChargingStation? = nil
    @State private var showFilterSheet: Bool = false
    
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 53.1424, longitude: -7.6921),
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
    )
    
    var body: some View {
            ZStack {
                Map(position: $position) {
                    ForEach(controller.filteredStations) { station in
                        Annotation(station.name ?? "EV Charger", coordinate: station.coordinate) {
                            Button {
                                selectedStation = station
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.green.opacity(0.15))
                                        .frame(width: 42, height: 42)

                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 28, height: 28)

                                    Image(systemName: "bolt.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14, weight: .bold))
                                }
                                .shadow(color: .green.opacity(0.4), radius: 6)
                            }
                        }
                    }
                }
                .onAppear {
                    controller.loadStations()
                }
                .sheet(item: $selectedStation) { station in
                    StationDetailView(station: station)
                }

                VStack {
                    HStack {
                        Spacer()
                        Button {
                            showFilterSheet.toggle()
                        } label: {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .font(.system(size: 28))
                                .padding()
                                .background(.ultraThinMaterial, in: Circle())
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheet(controller: controller)
            }
        }
    }
