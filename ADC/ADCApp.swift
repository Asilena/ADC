//
//  ADCApp.swift
//  ADC
//
//  Created by Elisa Berkane on 10/07/2022.
//

import SwiftUI
import FirebaseCore
import Firebase


@main
struct ADCApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
            
        }
    }
}
