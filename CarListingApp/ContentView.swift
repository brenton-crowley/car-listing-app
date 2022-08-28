//
//  ContentView.swift
//  CarListingApp
//
//  Created by Brent on 15/8/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var model = ViewModel()
    
    @State private var selectedCardId: UUID?
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                ForEach(model.cars) { car in
                    ExpandableCardView(selectedCardId: $selectedCardId,car: car)
                        .onTapGesture {

                            withAnimation {
                                selectedCardId = selectedCardId == car.id ? nil : car.id                                
                            }
                        }
                }
                .padding()
            }
            .background(
                Color.secondary
                    .opacity(0.1)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
