//
//  ContentView.swift
//  CarListingApp
//
//  Created by Brent on 15/8/2022.
//

import SwiftUI

struct ContentView: View {
    
    private enum PriceFilter: Double, CaseIterable {
        case one = 50000.0
        case two = 100000.0
        case three = 200000.0
        case four = 400000.0
        
        var labelText: String {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 0
            
            if let amount = formatter.string(from: self.rawValue as NSNumber) { return amount }
            
            return ""
        }
    }
    
    @ObservedObject private var model = ViewModel()
    
    @State private var selectedCardId: UUID?
    @State private var selectedPriceFilter: PriceFilter = PriceFilter.allCases.last!
    @State private var filterText: String = ""
    
    var filteredListOfCars: [Car] {
        model.cars.filter({ $0.marketPrice < selectedPriceFilter.rawValue })
    }
    
    var body: some View {
        
        NavigationView {
            VStack (alignment: .leading) {
                titleLabel
                priceFilterControl
                carResultsView
                
            }
            .animation(.default, value: filteredListOfCars.count)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                selectedCardId = filteredListOfCars.first?.id
            }
            .onChange(of: selectedPriceFilter) { newValue in
                selectedCardId = filteredListOfCars.first?.id
            }
        }
    }
    
    var titleLabel: some View {
        Text("Car Listing")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.leading)
            .foregroundColor(.blue)
    }
    
    var priceFilterControl: some View {
        VStack (alignment: .leading) {
            Text("Use the control to select a maximum price.")
                .font(.caption)
            Picker ("Price Filter", selection: $selectedPriceFilter) {
                ForEach(PriceFilter.allCases, id: \.self) { priceFilter in
                    
                    Text(priceFilter.labelText)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
    }
    
    var carResultsView: some View {
        
        ZStack {
            
            if filteredListOfCars.isEmpty {
                Color.secondary
                    .opacity(0.1)
                Text("No cars in this price range. \nChoose another price range.")
                    .multilineTextAlignment(.center)
            } else {
                carList
            }
            
        }
        
    }
    
    var carList: some View {
        
        ScrollView {
            ForEach(filteredListOfCars) { car in
                ExpandableCardView(selectedCardId: $selectedCardId,car: car)
                    .onTapGesture {
                        
                        withAnimation {
                            selectedCardId = selectedCardId == car.id ? nil : car.id
                        }
                    }
                    .padding([.horizontal, .top])
            }
        }
        .background(
            Color.secondary
                .opacity(0.1)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
