//
//  MapView.swift
//  ADC
//
//  Created by Elisa Berkane on 17/07/2022.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    var lat:Double
    var long:Double
    var title:String
    
    // Create and configure map view
    func makeUIView(context: Self.Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        //Create the pin location of the shop
        let shopLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        
        //Center the map on the place location
        mapView.setCenter(shopLocation, animated: true)
        mapView.setRegion(MKCoordinateRegion(center: shopLocation, latitudinalMeters: 100, longitudinalMeters: 100), animated: false)
        
        // Create annotations
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = shopLocation
        mapView.addAnnotation(annotation)
        
        // Format the map
        mapView.isScrollEnabled = false        
        
        // Retutn the map
        return mapView
        
    }
    
    // Update the element if needed
    func updateUIView(_ uiView: MKMapView, context: Self.Context) {
        
    }
    
        
    }
    


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(lat: 0.0, long: 0.0, title:"Test")
    }
}
