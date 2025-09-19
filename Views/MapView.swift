import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var adventureModel = AdventureViewModel()
    @StateObject private var adventurePlaceModel = AdventuePlaceViewModel()
    @State private var selectedTab: Tab = .map
    
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var isShowingLookAround = false
    
    @State private var route: MKRoute?
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.009),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    @State private var locationManager = CLLocationManager()
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                Map(position: $cameraPosition) {


                    
                    ForEach(adventurePlaceModel.places) { place in
                        Annotation(
                            place.name,
                            coordinate: CLLocationCoordinate2D(
                                latitude: place.latitude,
                                longitude: place.longitude
                            ),
                            anchor: .bottom
                        ) {
                            VStack(spacing: 4) {
                                Image(systemName: "location")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.white)
                                    .frame(width: 20, height: 20)
                                    .padding(7)
                                    .background(.blue.gradient, in: .circle)
                                
                                Text(place.name)
                                    .font(.cardSmallText)
                                    .padding(4)
                                    .background(Color.AppButtonText)
                                    .cornerRadius(5)
                                    .contextMenu {
                                        Button("Open Look Around", systemImage: "binoculars") {
                                            Task {
                                                if let scene = await getLookAroundScene(
                                                    from: CLLocationCoordinate2D(
                                                        latitude: place.latitude,
                                                        longitude: place.longitude
                                                    )
                                                ) {
                                                    lookAroundScene = scene
                                                    isShowingLookAround = true
                                                }
                                            }
                                        }
                                        
                                        Button("Get Direction", systemImage: "arrow.turn.down.right") {
                                            let destination = CLLocationCoordinate2D(
                                                    latitude: place.latitude,
                                                    longitude: place.longitude
                                                )
                                                getDirections(to: destination)
                                            
                                        }
                                    }
                            }
                        }
                    }
                    
                    
                    UserAnnotation()
                    
                    if let route{
                        MapPolyline(route)
                            .stroke(Color.blue, lineWidth: 3)
                    }
                }
                
                .onAppear {
                    adventureModel.fetchAdventure()
                    locationManager.requestWhenInUseAuthorization()
                }
                .navigationBarHidden(true)
                .mapControls {
                    VStack {
                        Spacer(minLength: 300)
                        VStack(spacing: 8) {
                            MapCompass()
                            MapPitchToggle()
                            MapUserLocationButton()
                            MapScaleView()
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .lookAroundViewer(
                    isPresented: $isShowingLookAround,
                    initialScene: lookAroundScene
                )
                
                VStack{
                    Spacer()
                    //adventure category raw
                    AdventureCategoryRaw(adventureViewModel: adventureModel) { categoryId in
                        adventurePlaceModel.fetchPlacesByCategory(for: categoryId) { places in
                            guard !places.isEmpty else {return}
                            let coordinates = places.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
                            
                            var mapRect = MKMapRect.null
                            for coordinate in coordinates {
                                let point = MKMapPoint(coordinate)
                                let rect = MKMapRect(x: point.x, y: point.y, width: 0.01, height: 0.01)
                                mapRect = mapRect.union(rect)
                        
                                let region = MKCoordinateRegion(mapRect)
                                
                                cameraPosition = .region(region)
                            }

                        }
                        
                    }.padding(.vertical, 8)
                     .padding(.horizontal, 12)
                     .background( Capsule().fill(Color.white).overlay(Capsule().stroke(Color.white, lineWidth: 1)))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                }

            }
        }
    }
    
    // function for look around
    func getLookAroundScene(from coordinate: CLLocationCoordinate2D) async -> MKLookAroundScene? {
        do {
            return try await MKLookAroundSceneRequest(coordinate: coordinate).scene
        } catch {
            print("Cannot retrieve Look Around scene: \(error.localizedDescription)")
            return nil
        }
    }
    
    //get user location
    func getUserLocation() async -> CLLocationCoordinate2D?{
        let updates = CLLocationUpdate.liveUpdates()
        do{
            let update = try await updates.first{$0.location?.coordinate != nil}
            return update?.location?.coordinate
        } catch{
            print("can not get user location")
            return nil
        }
        
    }
    
    
    //get direction/ route
    func getDirections( to destination: CLLocationCoordinate2D){
        Task{ guard let userLocation = await getUserLocation() else {return}
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: userLocation))
            request.destination = MKMapItem(placemark: .init(coordinate: destination))
            request.transportType = .any
            do{
                let directions = try await MKDirections(request: request).calculate()
                route = directions.routes.first
            } catch{
                print("Show error \(error.localizedDescription)")
               
            }
        }
    }
}
