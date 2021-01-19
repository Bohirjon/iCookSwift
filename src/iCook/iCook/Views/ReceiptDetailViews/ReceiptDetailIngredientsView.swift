//
//  File.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 15/01/21.
//


import Foundation
import Combine
import SwiftUI
import SDWebImageSwiftUI

struct ReceiptDetailIngredientsView : View {
    @EnvironmentObject var viewModel: ReceiptDetailViewModel
    
    var body: some View {
        VStack {
            if viewModel.receiptInformation == nil {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                List(viewModel.receiptInformation!.extendedIngredients) { ingredient in
                    HStack {
                        WebImage(url: URL(string: "\(AppConstract.IngredientImageUrl)\(ingredient.image)"))
                            .resizable()
                            .placeholder {
                                ActivityIndicator(.constant(true))
                            }
                            .frame(width: 40, height: 40, alignment: .leading)
                        
                        Text("\(ingredient.originalString)")
                    }
                }
            }
        }
        .onAppear(perform: {
            viewModel.fetchReceiptInformation()
        })
    }
}


struct ReceiptDetailIngredientsView_Previews: PreviewProvider {
    static let viewModel = ReceiptDetailViewModel(receiptDetailApi: ReceipDetialApi(), receiptId: 656329)
    
    static var previews: some View {
        return ReceiptDetailIngredientsView()
            .environmentObject(viewModel)
    }
}
