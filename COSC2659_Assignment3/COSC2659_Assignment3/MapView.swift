//
//  ContentView.swift
//  COSC2659_Assignment3
//
//  Created by Bảo Duy Đào on 13/9/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    
    // Map region state
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.5186, longitude: -86.8104), // Example starting location
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // States
    @State private var selectedVehicleType: String = "Motorcycle"
    @State private var preferredFuelType: String = "RON 95-V"
    @State private var avoidTollRoad: Bool = false
    @State private var isShowingVehicleSelector: Bool = false
    @State private var isShowingCautionView: Bool = false
    @State private var isShowingSettingsView: Bool = false
    @State private var isShowingSearchPanel: Bool = false
    @State private var searchText: String = ""
    @State private var selectedCautionType: String = ""
    
    var body: some View {
        ZStack {
            // Map View with user's current location
            Map(coordinateRegion: $region, showsUserLocation: true)
                .onAppear {
                    if let location = locationManager.location {
                        updateRegion(for: location.coordinate)
                    }
                }
                .onChange(of: locationManager.location) { newLocation in
                    if let location = newLocation {
                        updateRegion(for: location.coordinate)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            
            // Search Bar at the top
            VStack {
                // Search Bar
                VStack {
                    SearchBar(searchText: $searchText, onLocationSelected: { location in
                        updateRegion(location: location) // Update using CLLocationCoordinate2D
                    })
                    .padding(.top, 10)
                }
                
                HStack {
                    // Hamburger Menu
                    HStack {
                        Image(systemName: "line.horizontal.3")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                    .foregroundColor(.white)
                    .onTapGesture {
                        // Show the settings view
                        isShowingSettingsView.toggle()
                    }
                    .padding(.leading, 20)

                    Spacer()
                    
                    // Speed Display
                    VStack {
                        Text("0")
                            .font(.system(size: 36, weight: .bold)) // Larger text size
                        Text("km/h")
                            .font(.caption)
                    }
                    .padding(25) // Increase padding to make the circle bigger
                    .background(Circle().fill(Color.black.opacity(0.7))) // Circle background
                    .foregroundColor(.white)
                    .padding(.trailing, 20)
                }
                
                Spacer()
                
                HStack {
                    // Floating button to center on user's location
                    Button(action: {
                        if let location = locationManager.location {
                            updateRegion(for: location.coordinate) // Extract the CLLocationCoordinate2D from CLLocation
                        }
                    }) {
                        Image(systemName: "location.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .background(Circle().fill(Color.white))
                    .shadow(radius: 4)
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    HStack {
                        // Vehicle Type Selector
                        Text(selectedVehicleType)
                        Image(systemName: "arrow.down.circle.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .aspectRatio(contentMode: .fit)
                    }
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .frame(minWidth: 120)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.orange))
                    .foregroundColor(.white)
                    .onTapGesture {
                        // Show the vehicle selector modal
                        isShowingVehicleSelector.toggle()
                    }
                    
                    Spacer()
                    
                    // Caution Button
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(10)
                    }
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Circle().fill(Color.red))
                    .foregroundColor(.white)
                    .onTapGesture {
                        // Show the caution view modal
                        isShowingCautionView.toggle()
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $isShowingVehicleSelector) {
            VehicleSelectorView(selectedVehicleType: $selectedVehicleType, preferredFuelType: $preferredFuelType, avoidTollRoad: $avoidTollRoad)
        }
        .sheet(isPresented: $isShowingCautionView) {
            CautionView(selectedCautionType: $selectedCautionType)
        }
        .sheet(isPresented: $isShowingSettingsView) {
            SettingsView()
        }
    }
    
    // Function to update the map region based on CLLocationCoordinate2D
    func updateRegion(for location: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }

    // Function to update the map region based on CLLocationCoordinate2D
    func updateRegion(location: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}



