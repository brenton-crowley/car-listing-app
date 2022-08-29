//
//  ViewModel.swift
//  CarListingApp
//
//  Created by Brent on 15/8/2022.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var cars: [Car] = []
    
    init() {
        
        do {
            try loadCars()
        } catch {
            print(error)
        }
        
    }
    
    private func loadCars() throws {
        
        guard let url = Bundle.main.url(forResource: "car_list", withExtension: "json") else { return }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        
        self.cars = try decoder.decode([Car].self, from: data)
        
        dump(cars)
        
    }
}
