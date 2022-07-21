//
//  Pattern.swift
//  ADC
//
//  Created by Elisa Berkane on 14/07/2022.
//

import Foundation

class Pattern: Identifiable, Decodable, ObservableObject {
    
    var id:String = ""
    var name:String = ""
    var source:String = ""
    var image:String = ""
    var time:Int = 0
    var fabricsNeeded:[FabricNeeded] = [FabricNeeded]()
    var claspsNeeded:[ClaspsNeeded]? = [ClaspsNeeded]()
    var steps:[String] = [""]
    var photos:[String] = [""]
    var video:String = ""

}

class FabricNeeded: Identifiable, Decodable, ObservableObject {
    
    var id:String = ""
    var type:String = ""
    var length:Int = 0
    var width:Int = 0
    
}

class ClaspsNeeded: Identifiable, Decodable, ObservableObject {
    
    var id:String = ""
    var type:String = ""
    var quantity:Int = 0
    
}
