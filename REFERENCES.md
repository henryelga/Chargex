# References

## Apple Frameworks & SDKs

- **SwiftUI** – Used for all UI components, layouts, navigation, and property wrappers.
  https://developer.apple.com/documentation/swiftui

- **MapKit** – Used for `Map`, `MKCoordinateRegion`, `MapCameraPosition`, `Annotation`, `MKMapItem`, `MKPlacemark`, and Apple Maps directions.
  https://developer.apple.com/documentation/mapkit

- **CoreLocation** – Used for `CLLocationManager`, `CLLocationCoordinate2D`, `CLLocationManagerDelegate`, and location permissions.
  https://developer.apple.com/documentation/corelocation

- **Combine** – Used for `ObservableObject`, `@Published`, `Publishers.CombineLatest4`, `AnyCancellable`, and `.store(in:)`.
  https://developer.apple.com/documentation/combine

- **SwiftData** – Used for `@Model`, `@Query`, `modelContext`, and persistent station saving.
  https://developer.apple.com/documentation/swiftdata

- **Charts** – Used for `Chart` and `BarMark` in the Dashboard (iOS 16+).
  https://developer.apple.com/documentation/charts

- **UserNotifications** – Used for scheduling and managing charging notifications.
  https://developer.apple.com/documentation/usernotifications

- **Foundation** – Used for `JSONEncoder`, `JSONDecoder`, `UserDefaults`, `Timer`, `UUID`, `Date`, `Calendar`, `DispatchQueue`, `Bundle`, and `Data`.
  https://developer.apple.com/documentation/foundation

## Data Source

- **OpenStreetMap via Overpass API** – Source of `chargers_ireland.json`, containing EV charging station data with tags such as `socket:type2`, `socket:chademo`, `fee`, and `operator`.
  https://overpass-api.de
  https://www.openstreetmap.org

## Tutorials & Learning Resources

- **Gallaugher, J. (2025). *Ch. 1.19 Easily Add a Launch Screen to your SwiftUI App (2025)*. YouTube.**
  Used for implementing the launch screen via Info.plist, including custom background colour and image asset sizing.
  https://www.youtube.com/watch?v=v1grobvTJ5Y

## Design Patterns

- **Singleton Pattern** – Used in `NotificationManager` and `NotificationDelegate`.
  https://developer.apple.com/documentation/swift/managing-a-shared-resource-using-a-singleton

- **MVC Architecture** – Controllers manage logic, models hold data, SwiftUI views handle presentation.
  https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html

- **Weak Self in Closures** – Used in `Timer` and Combine sink callbacks to avoid retain cycles.
  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/

## Info.plist

- **NSLocationWhenInUseUsageDescription** – Privacy key for requesting location access.
  https://developer.apple.com/documentation/bundleresources/information-property-list/nslocationwheninuseusagedescription
