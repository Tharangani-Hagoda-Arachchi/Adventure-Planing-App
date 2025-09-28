import SwiftUI
import MapKit

struct MapView: View {
    
    
    // for dark mode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @StateObject private var adventureModel = AdventureViewModel()
    @StateObject private var adventurePlaceModel = AdventuePlaceViewModel()
    
    @State private var selectedTab: Tab = .map
    
    //for selection of one place
    var selectedPlace: AdventurePlace? = nil
    
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
                            MapAnnotationView(
                                place: place,
                                fontColor: fontColor,
                                markerColor: markerColor,
                                onLookAround: {
                                    Task{
                                        if let scene = await getLookAroundScene(from: CLLocationCoordinate2D(
                                            latitude: place.latitude,
                                            longitude: place.longitude
                                        )
                                        ){
                                            lookAroundScene = scene
                                            isShowingLookAround = true
                                        }
                                    }
                                },
                                onGetDirection: {
                                    let destination = CLLocationCoordinate2D(
                                        latitude: place.latitude,
                                        longitude: place.longitude
                                    )
                                    getDirections(to: destination)
                                }
                            )
                            
                        }
                    }
                    
                    
                    UserAnnotation()
                    
                    if let route{
                        MapPolyline(route)
                            .stroke(Color.red, lineWidth: 4)
                    }
                }
                
                .onAppear {
                    adventureModel.fetchAdventure()
                    adventurePlaceModel.fetchAllAdventure()
                    locationManager.requestWhenInUseAuthorization()
                    
                    //for selected place
                    if let place = selectedPlace{
                        let region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            
                        )
                        cameraPosition = .region(region)
                    }
                }
                .onChange(of: adventurePlaceModel.places){ _, newPlace in
                    if let place = selectedPlace {
                        let region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude),
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // Zoom to that place
                        )
                        withAnimation(.easeInOut(duration: 1.0) ){
                            cameraPosition = .region(region)
                        }
                    }else{
                        adjustCamera(places: adventurePlaceModel.places)
                    }
                    
                    
                }
                //.navigationBarHidden(true)
                
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
                        .background( Capsule().fill(backgroundColor).overlay(Capsule().stroke(backgroundColor, lineWidth: 1)))
                        .foregroundColor(fontColor)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                }
                
            }
        }.preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    //adjust camera to show all
    func adjustCamera(places: [AdventurePlace]){
        guard !places.isEmpty else{return}
        
        let coordinates = places.map {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        }
        let latitudes = coordinates.map { $0.latitude }
        let longitudes = coordinates.map { $0.longitude }
        
        let minLat = latitudes.min() ?? 0
        let maxLat = latitudes.max() ?? 0
        let minLng = longitudes.min() ?? 0
        let maxLng = longitudes.max() ?? 0
        
        let centerLat = (minLat + maxLat) / 2
        let centerLng = (minLng + maxLng) / 2
        
        let latDelta = max(maxLat - minLat, 0.01) * 1.2
        let lngDelta = max(maxLng - minLng, 0.01) * 1.2
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLng),
            span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        )
        
        withAnimation(.easeInOut(duration: 1.0)){
            cameraPosition = .region(region)
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
    
    
    
    //color change according to theme
    private var fontColor: Color{
        isDarkMode ? Color.AppButtonText : Color.AppPrimaryTextField
        
    }
    
    private var markerColor: Color{
        isDarkMode ? Color.AppPrimaryTextField: Color.AppButtonText
        
    }
    
    private var backgroundColor: Color{
        isDarkMode ? Color.AppPrimaryTextField.opacity(0.7): Color.AppButtonText
        
    }
}
