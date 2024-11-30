//
//  MapView.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 11/10/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var coordinate : CLLocationCoordinate2D
    
    
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinate, latitudinalMeters: 750, longitudinalMeters: 750)))
    }
}
