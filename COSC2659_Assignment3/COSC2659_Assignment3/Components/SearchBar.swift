//
//  SearchPanel.swift
//  COSC2659_Assignment3
//
//  Created by Bảo Duy Đào on 13/9/24.
//

import SwiftUI
import MapKit

struct SearchBar: View {
    @Binding var searchText: String
    @State private var searchResults: [MKMapItem] = [] // Stores search results
    @State private var isSearching = false // Controls the search process
    @State private var debounceWorkItem: DispatchWorkItem? // For debouncing
    
    // A closure to notify the MapView about location selection
    var onLocationSelected: ((CLLocationCoordinate2D) -> Void)? = nil
    
    var body: some View {
        VStack {
            HStack {
                // Search icon
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                // TextField for entering search query
                TextField("Search", text: $searchText, onCommit: {
                    // Perform search when Enter is pressed
                    if let firstResult = searchResults.first {
                        selectLocation(firstResult)
                    }
                })
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .disableAutocorrection(true)
                .onChange(of: searchText) { newValue in
                    debounceSearch(query: newValue) // Trigger debounce function
                }
                
                // Clear button
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        searchResults = [] // Clear search results when text is cleared
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray5)))
            .shadow(radius: 4)
            
            // Show search results in a List
            if !searchResults.isEmpty {
                List(searchResults, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text(item.name ?? "Unknown")
                            .font(.headline)
                        Text(item.placemark.title ?? "No Address")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        // Update the search text and select the location
                        selectLocation(item)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
    
    // Debounce the search query input
    func debounceSearch(query: String) {
        // Cancel any existing work item to avoid unnecessary searches
        debounceWorkItem?.cancel()
        
        // Create a new work item with a delay of 0.5 seconds
        let newWorkItem = DispatchWorkItem {
            performSearch(query: query)
        }
        
        // Store the new work item and execute it after the delay
        debounceWorkItem = newWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: newWorkItem)
    }
    
    // Perform search using MKLocalSearch
    func performSearch(query: String) {
        guard !query.isEmpty else {
            searchResults = [] // Clear results if query is empty
            return
        }
        
        isSearching = true
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            isSearching = false
            if let response = response {
                self.searchResults = response.mapItems
            } else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    // Function to handle selecting a location
    func selectLocation(_ item: MKMapItem) {
        searchText = item.name ?? "Unknown"
        searchResults = [] // Optionally clear the search results
        if let location = item.placemark.location?.coordinate {
            // Notify the parent view (MapView) about the selected location
            onLocationSelected?(location)
        }
    }
    
    // Function to handle what happens when a result is tapped
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        // Notify the parent view to center the map
        onLocationSelected?(location)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}






