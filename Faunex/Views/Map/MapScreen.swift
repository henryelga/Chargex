import SwiftUI
import MapKit
import Combine

struct MapScreen: View {
    
    @StateObject private var controller = MapController()
    @StateObject private var locationManager = LocationManager()
    @State private var hasCentered = false
    
    @State private var selectedStation: ChargingStation? = nil
    @State private var showFilterSheet: Bool = false
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 53.1424, longitude: -7.6921),
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
    )
    
    func updateMapPosition(force: Bool = false) {
        guard let coord = locationManager.userLocation else { return }
        
        if hasCentered && !force { return }
        
        hasCentered = true
        
        withAnimation {
            position = .region(
                MKCoordinateRegion(
                    center: coord,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            )
        }
    }
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                
                if let userLocation = locationManager.userLocation {
                    Annotation("You", coordinate: userLocation) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 16, height: 16)
                    }
                }
                
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
                locationManager.requestPermission()
            }
            .onChange(of: locationManager.userLocation?.latitude) { _ in
                updateMapPosition()
            }

            .onChange(of: locationManager.userLocation?.longitude) { _ in
                updateMapPosition()
            }
            .onReceive(locationManager.$userLocation) { _ in
                updateMapPosition()
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
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        locationManager.handleLocationButtonTap()
                        updateMapPosition(force: true)
                    } label: {
                        Image(systemName: "location.fill")
                            .font(.system(size: 20))
                            .padding()
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showFilterSheet) {
            FilterSheet(controller: controller)
        }
    }
}
