import SwiftUI
import MapKit

struct MapScreen: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 53.1424, longitude: -7.6921),
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
    )
    
    var body: some View {
        Map(position: $position) {
            
            ForEach(viewModel.stations) { station in
                Annotation(
                    station.name ?? "EV Charger",
                    coordinate: station.coordinate
                ) {
                    Image(systemName: "bolt.car.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                }
            }
        }
        .onAppear {
            viewModel.loadStations()
        }
    }
}
