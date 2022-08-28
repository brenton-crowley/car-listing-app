//
//  ExpandableCardView.swift
//  CarListingApp
//
//  Created by Brent on 15/8/2022.
//

import SwiftUI

struct ExpandableCardView: View {
    
    private struct Constants {
        static let collaspsedHeight:CGFloat = 150.0
        static let expandedHeight:CGFloat = 300.0
        
        static let cardDetailBackground:Color = .white
    }
    
    var isExpanded: Bool { selectedCardId == car?.id }
    
    @Binding var selectedCardId: UUID?
    
    var car: Car?
    
    var body: some View {
        
        VStack {
            GeometryReader { geo in
                HStack (spacing: 0) {
                    
                    imageView
                        .frame(width: geo.size.width * 0.5)
                    detailsView
                        .frame(width: geo.size.width * 0.5)
                    
                }
                .clipShape(
                    RoundedRectangle(cornerRadius: 20.0)
                )
            }
        }
        .frame(height: isExpanded ? Constants.expandedHeight : Constants.collaspsedHeight)
    }
    
    var imageView: some View {
        Image(car?.model ?? "Tacoma")
            .resizable()
            .scaledToFill()
    }
    
    var detailsView: some View {
        ZStack (alignment: .leading) {
            Rectangle()
                .foregroundColor(Constants.cardDetailBackground)
            VStack (alignment: .leading) {
                detailHeader
                
                Spacer()
                if isExpanded {
                    detailBody
                        .opacity(isExpanded ? 1 : 0)
                }
                Spacer()
                
                detailFooter
            }
            .padding()
        }
        
    }
    
    var detailHeader: some View {
        
        VStack (alignment: .leading) {
            Text(car?.model ?? "Model name")
                .fontWeight(.bold)
            Text("$\(Int(car?.customerPrice ?? 0.0) )")
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
        
    }
    
    var detailBody: some View {
        VStack (alignment: .leading, spacing: 20.0) {
            // Pros
            bulletList(car?.prosList ?? ["One", "Two", "Three"],
                       withTitle: "Pros")
            // Cons
            bulletList(car?.consList ?? ["One", "Two", "Three"],
                       withTitle: "Cons")
        }
    }
    
    var detailFooter: some View {
        Text(isExpanded ? "Hide details" : "Show details")
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.blue)
    }
    
    @ViewBuilder
    private func bulletList(_ list:[String], withTitle title: String) -> some View {
        
        var list = list
        list.removeAll { $0.isEmpty }
        
        return VStack (alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
            
            ForEach(list.indices, id:\.self) { listIndex in
                
                let text = "\u{2022} \(list[listIndex])"
                Text(text)
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .padding(.leading)
                
            }
            
        }
        
    }
}

struct ExpandableCardView_Previews: PreviewProvider {
    static var previews: some View {

        ExpandableCardView(selectedCardId: Binding.constant(UUID()))
    }
}
