//
//  MapKit.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-09.
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation


struct MapView: View {
    @ObservedObject var location: Location
    @State var region: MKCoordinateRegion = MKCoordinateRegion()
   
    init(location: Location ){
        self.location = location
    }
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.location.manager.startUpdatingLocation()
                self.location.manager.requestLocation()
                guard let location = self.location.location else { return }
                self.region = MKCoordinateRegion(
                    center: location,
                    span: MKCoordinateSpan(
                        latitudeDelta: 30.00,
                        longitudeDelta: 30.00)
                    )
            
            }
    }
    func refreshMap(location: Location) {
        print(location)
        guard let location = self.location.location else { return }
        self.region = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(
                latitudeDelta: 30.00,
                longitudeDelta: 30.00)
            )
     
    }
    
   
    
   
}
@available(iOS 16.0, *)
struct LocationView: View {
    @StateObject var location: Location = Location()
    var map: MapView {
        MapView(location: location)
    }
  
    var body: some View {
        VStack {
            GeometryReader { r in
                
                map.frame(height:r.size.height/2).top()
                
                Button("search", action: {
                    self.map.refreshMap(location: location)
                })
                .frame(width: r.size.width, height: 40,  alignment: .center)
                .bottom()
                .background(.gray)
                .border(.bar, width: 4)
                .offset(y: r.size.height / 2)
                
                
            }
        }.top()
        .standard()
       
        .backButton()
    }
}

@available(iOS 16.0, *)
struct LocationPreview: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}


class Location: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }

   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus
    ) {
        // Handle changes if location permissions
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            let latitude = loc.coordinate.latitude
            let longitude = loc.coordinate.longitude
            // Handle location update
           
            self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            print(location)
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // Handle failure to get a user’s location
        print(error)
    }
    
    func setLocation(location: CLLocationCoordinate2D) {
        self.location = location
    }
}
