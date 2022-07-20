//
//  Store.swift
//  ADC
//
//  Created by Elisa Berkane on 17/07/2022.
//

import Foundation

class Store: Identifiable, Decodable, ObservableObject {
    
    var id:UUID?
    var name:String
    var city:String?
    var type:String
    var latitude:Double?
    var longitude:Double?
    var website:String?

}
