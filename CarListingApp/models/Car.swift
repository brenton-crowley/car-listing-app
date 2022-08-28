//
//  Car.swift
//  CarListingApp
//
//  Created by Brent on 15/8/2022.
//

import Foundation

struct Car: Decodable, Identifiable {
    
    var customerPrice, marketPrice: Double
    var rating: Int
    var make, model: String
    var consList, prosList: [String]
    
    let id: UUID = UUID()    
}
