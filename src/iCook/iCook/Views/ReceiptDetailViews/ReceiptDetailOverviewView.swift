//
//  ReceiptDetailOverviewView.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 15/01/21.
//

import Foundation
import Combine
import SwiftUI
import SDWebImageSwiftUI

struct ReceiptDetailOverviewView: View {
    @EnvironmentObject var viewModel: ReceiptDetailViewModel
    
    var body: some View {
        VStack {
            if viewModel.receiptInformation == nil {
                ActivityIndicator(Binding<Bool>.constant(true))
            } else {
                WebImage(url: URL(string: viewModel.receiptInformation!.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius:3)
                    .cornerRadius(12.0)
                    .overlay(RoundedRectangle(cornerRadius: 12.0)
                                .stroke(Color.black.opacity(0.5)))
                    .padding()
                Text(viewModel.receiptInformation!.title)
                Form {
                    HStack {
                        Image(systemName: "timer")
                        Text("Ready in \(viewModel.receiptInformation!.readyInMinutes) minutes")
                    }
                    HStack {
                        Image(systemName: "flame")
                        Text("\(viewModel.receiptInformation!.healthScore) Calories")
                    }
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        Text("\(viewModel.receiptInformation!.aggregateLikes) Likes")
                    }
                    HStack {
                        Image(systemName: "star")
                        Text("\(viewModel.receiptInformation!.spoonacularScore) Score from spooncular")
                    }
                }
                Spacer()
            }
        }
    }
}


struct ReceiptDetailOverviewView_Previews: PreviewProvider {
    static let viewModel = ReceiptDetailViewModel(receiptDetailApi: ReceipDetialApi(), receiptId: 656329)
    
    static var previews: some View {
        viewModel.fetchReceiptInformation()
        return ReceiptDetailOverviewView()
            .environmentObject(viewModel)
    }
}
