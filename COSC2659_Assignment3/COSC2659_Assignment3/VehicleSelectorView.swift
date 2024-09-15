//
//  VehicleSelectorView.swift
//  COSC2659_Assignment3
//
//  Created by Bảo Duy Đào on 13/9/24.
//

import SwiftUI

struct VehicleSelectorView: View {
    @Binding var selectedVehicleType: String
    @Binding var preferredFuelType: String
    @Binding var avoidTollRoad: Bool
    
    // Access the environment to dismiss the modal view (optional)
    @Environment(\.presentationMode) var presentationMode

    let vehicleTypes = ["Motorcycle", "Car", "Truck", "Bus"]
    let fuelTypes = ["RON 95-V", "RON 92", "Diesel", "Electric"]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            Text("Navigation")
                .font(.title)
                .padding()
            
            // Vehicle Type Selection
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(vehicleTypes, id: \.self) { type in
                        VStack {
                            Image(systemName: "car.fill") // Replace with appropriate vehicle images
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding()
                                .background(type == selectedVehicleType ? Color.blue : Color.clear)
                                .cornerRadius(10)
                                .foregroundColor(.gray)
                            
                            Text(type)
                                .font(.headline)
                                .foregroundColor(type == selectedVehicleType ? .blue : .black)
                        }
                        .onTapGesture {
                            selectedVehicleType = type
                            // Optional: Automatically dismiss modal after selection
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            // Preferred Fuel Type Selection
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "fuelpump.fill")
                    Text("Preferred fuel type")
                    Spacer()
                    Text(preferredFuelType)
                        .fontWeight(.semibold)
                }
                .onTapGesture {
                    // Change the fuel type directly (without needing a button)
                    preferredFuelType = fuelTypes.randomElement() ?? "RON 95-V"
                }
                
                Divider()
                
                // Avoid Toll Roads Toggle
                HStack {
                    Image(systemName: "road.lanes")
                    Text("Avoid toll roads")
                    Spacer()
                    Toggle("", isOn: $avoidTollRoad)
                        .labelsHidden()
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct VehicleSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleSelectorView(selectedVehicleType: .constant("Motorcycle"), preferredFuelType: .constant("RON 95-V"), avoidTollRoad: .constant(false))
    }
}
