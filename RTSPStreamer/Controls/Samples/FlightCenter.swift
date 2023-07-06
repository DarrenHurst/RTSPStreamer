//
//  FlightCenter.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-02-07.
//

import Foundation
import SwiftUI
import CoreLocation
@available(iOS 16.0, *)
struct FlightCenterView: View {
    @ObservedObject var view = ViewModel(plane: PassegerFlight(flightId: 0001))
    @State var isLoading: Bool = false

    var body: some View{
      
        ScrollView(.vertical){
            buildHeader()
        VStack {
                Text("Flight Information")
                
            }.frame(width:UIScreen.screenWidth-40, height: UIScreen.screenHeight - 300, alignment: .top).padding(.top).font(.Large)
                
            .overlay {
                buttonBar()
                buildInfoSection().padding(.top, 40)
            }.frame(alignment:.top)
           //.border(.bar, width: 5)
            .padding(20)
            }
            .background(planeAnimation())
            .standard()
            .frame(alignment: .top)
            .ignoresSafeArea()
        
        .onAppear() {
            Task{
                view.plane = Plane(plane: PassegerFlight(flightId: view.plane.flightId))
                // TODO service
                // try! await view.fetch(planeId: 3333)
                self.isLoading = true
            }
          }
        .backButton()
    }

}
@available(iOS 16.0, *)
struct previews: PreviewProvider {
    static var previews: some View {
        FlightCenterView()
    }
}

@available(iOS 16.0, *)
enum DownloadError: Error {
    case decoderError
    case statusNotOk
}
@available(iOS 16.0, *)
extension FlightCenterView {
    class ViewModel: ObservableObject {
        var plane: Plane
        var company = {
            let name: String? = "Air Canada"
            let url: String? = "http://www.aircanada.com"
        }
        
        init(plane: PassegerFlight){
            self.plane = Plane(plane: PassegerFlight(flightId: 324).self as (any Flight))
        }
     
        @MainActor
           func fetch(planeId: Int) async throws -> Plane   {
               
               let (data, response) =
               try await URLSession.shared.data(from: URL(string: "someURL")!)
                   guard
                       let httpResponse = response as? HTTPURLResponse,
                     httpResponse.statusCode == 200
                   else {
                     throw DownloadError.statusNotOk
                   }
                   guard let decodedResponse = try? JSONDecoder().decode(Plane.self, from: data)
                   else {  throw DownloadError.decoderError
                   }
              
               return decodedResponse
           }
    }
    
}
 
///mark: - Data Structure
enum PlaneType: String, Codable {
    case plane747 = "747"
    case planeAirBus = "AirBus"

}
struct Passenger: Codable {
    var name: String?
    var seat: String?
    var passportId: String?
}
struct Cargo: Codable {
    var name: String?
    var address: String?
    var courierId: String?
}

struct Plane: Codable, Flight, Identifiable {
    //Flight Dependencies
    var id: UUID = UUID()
    var flightId: Int = 0000
    var planeType: PlaneType = .plane747
    var planeId: Int? = 0000
    var planePassenger: Passenger?
    var planeCargo: Cargo?
    
    init(plane: any Flight) {
        id = plane.id
        flightId = plane.flightId
        planeType = plane.planeType
        planeId = plane.planeId
    }
}

// Flight Builder
struct PassegerFlight: Flight {
    var planePassenger: Passenger?
    var planeCargo: Cargo?
    var flightId: Int
    var planeType: PlaneType = .plane747
    var planeId: Int? = 3333
    var location: CLLocation?
    var id: UUID = UUID()
}

struct CargoFlight: Flight {
    var planePassenger: Passenger?
    var planeCargo: Cargo?
    var flightId: Int
    var planeType: PlaneType = .planeAirBus
    var planeId: Int? = 2323
    var location: CLLocation?
    var id: UUID = UUID()
}

protocol Flight: Identifiable{
    var id: UUID { get set }
    var flightId : Int  { get set }
    var planeType: PlaneType { get set }
    var planeId: Int? { get set }
    var planePassenger: Passenger? { get set }
    var planeCargo: Cargo? { get set }}

@available(iOS 16.0, *)
extension FlightCenterView {
    
    fileprivate func planeAnimation() -> some View {
        return Image("plane").shadow(radius: 3).opacity(0.4).offset(y: isLoading ? -320: -600).animation(runSpring(), value: isLoading)
    }
    fileprivate func buttonBar() -> some View {
        return LazyHStack {
            Button("Passenger", action: {
                self.isLoading = true
                view.plane = Plane(plane: PassegerFlight(flightId: view.plane.planeId ?? 0))
                
            }).frame(width: (UIScreen.screenWidth / 3-10), alignment: .center)
                .padding().overlay{
                    
                }.border(.bar, width: 4)
            
            Button("Cargo", action: {
                self.isLoading = false
                view.plane = Plane(plane: CargoFlight(flightId: view.plane.planeId ?? 0))
            }).frame(width: (UIScreen.screenWidth / 3-10), alignment: .center)
            
                .padding().overlay{
                    
                }.border(.bar, width: 4)
            
            
        }.frame(width: UIScreen.screenWidth, height: 60, alignment: .top)
            .foregroundColor(.black)
            .zIndex(0)
            .offset(y: -180)
    }
    
    fileprivate func buildInfoSection() -> some View {
        return LazyVStack {
            Text("Flight Number: \(view.plane.flightId)").frame(width: UIScreen.screenWidth-80, alignment: .leading)
            Text("Plane Type: \(view.plane.planeType.rawValue)").frame(width: UIScreen.screenWidth-80, alignment: .leading)
            Text("Passengers: 155").frame(width: UIScreen.screenWidth-80, alignment: .leading)
            Text("Crew: 5").frame(width: UIScreen.screenWidth-80, alignment: .leading)
            Text("Status: On Time").frame(width: UIScreen.screenWidth-80, alignment: .leading)
        }.frame(width: UIScreen.screenWidth, alignment: .leading).offset(y: -100)
    }
    
    fileprivate func buildHeader() -> some View {
        return LazyHStack {
            Image("AirCanadaLogo").resizable()
                     .frame(width:115,height:105)
                     .offset(x:10, y:20)
                     .padding(30)
                .shadow(radius: 3.0).padding(.leading, 20)
            ZStack {
                Text("Airport")
                    .multilineTextAlignment(.leading)
                    .font(.Large)
                    .frame(width: UIScreen.screenWidth - 120, alignment: .topLeading)
                    .frame(alignment: .leading)
                    .offset(x: 5, y:-20)
                    .shadow(radius: 3)
                Text("YYZ")
                    .multilineTextAlignment(.leading)
                    .font(.XXLarge)
                    .frame(width: UIScreen.screenWidth - 120, alignment: .topLeading)
                    .frame(alignment: .leading)
                    .opacity(0.2)
                    .shadow(radius: 3)
                    .offset(y:20)
            }.offset(y:20)
        }.frame(height:180).padding(.top, 30).frame(alignment: .leading)
    }
    
}
