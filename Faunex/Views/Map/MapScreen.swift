import SwiftUI
import MapKit
import Combine

struct MapScreen: View {
    
    @StateObject private var controller = MapController()
    @StateObject private var locationManager = LocationManager()
    
    @State private var hasCentered = false
    @State private var selectedStation: ChargingStation? = nil
    @State private var showFilterSheet: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 53.1424, longitude: -7.6921),
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
    )
    
    // MARK: - Map Position Handling
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
            
            // MARK: - FULL SCREEN MAP
            mapView
            
            // MARK: - TOP RIGHT FILTER
            VStack {
                HStack {
                    Spacer()
                    
                    controlButton(
                        systemName: "line.3.horizontal.decrease.circle"
                    ) {
                        showFilterSheet.toggle()
                    }
                }
                Spacer()
            }
            .padding(16)
            
            // MARK: - BOTTOM RIGHT LOCATION
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    controlButton(
                        systemName: "location.fill"
                    ) {
                        locationManager.handleLocationButtonTap()
                        updateMapPosition(force: true)
                    }
                }
            }
            .padding(16)
        }
        
        // MARK: - Lifecycle
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
        
        // MARK: - Sheets
        .sheet(item: $selectedStation) { station in
            StationDetailView(station: station)
        }
        .sheet(isPresented: $showFilterSheet) {
            FilterSheet(controller: controller)
        }
    }
    
    // MARK: - MAP VIEW
    private var mapView: some View {
        Map(position: $position) {
            
            // User Location
            if let userLocation = locationManager.userLocation {
                Annotation("You", coordinate: userLocation) {
                    Circle()
                        .fill(Color.blue.opacity(0.9))
                        .frame(width: 12, height: 12)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
            }
            
            // Stations
            ForEach(controller.filteredStations) { station in
                Annotation(station.name ?? "EV Charger",
                           coordinate: station.coordinate) {
                    Button {
                        selectedStation = station
                    } label: {
                        StationPinView()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: - UNIFIED CONTROL BUTTON
    private func controlButton(
        systemName: String,
        action: @escaping () -> Void
    ) -> some View {
        
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color.chargexTextPrimary)
                .frame(width: 44, height: 44)
                .background(Color.chargexCard)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            colorScheme == .dark
                            ? Color.clear
                            : Color.black.opacity(0.25),
                            lineWidth: 1
                        )
                )
                .shadow(color: .black.opacity(0.10),
                        radius: 8, x: 0, y: 4)
        }
    }
}
