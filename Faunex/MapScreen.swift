import SwiftUI
import MapKit

struct MapScreen: View {
  @State private var position: MapCameraPosition = .region(
    MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090), // temporary, replace with latest whale latitute and longitute
      span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
  )
  var body: some View {
    Map(position: $position)	
      .ignoresSafeArea()
  }
}

