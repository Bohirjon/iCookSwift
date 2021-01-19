//
//  ReceiptDetailView.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 15/01/21.
//

import SwiftUI
import Combine

struct ReceiptDetailView: View {
    private let receipt: Receipt
    @ObservedObject var viewModel: ReceiptDetailViewModel
    
    init(receipt:Receipt) {
        viewModel = ReceiptDetailViewModel(receiptDetailApi: MockReceiptDetailApi(), receiptId: receipt.id)
        self.receipt = receipt
    }
    
    var body: some View {
        NavigationView {
            TabView {
                ReceiptDetailOverviewView()
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("Overview")
                    }
                ReceiptDetailIngredientsView()
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text("Ingredients")
                    }
                ReceiptDetailStepsView()
                    .tabItem {
                        Image(systemName: "dial.max")
                        Text("Steps")
                    }
            }
            .navigationBarTitle(receipt.title, displayMode: .inline)
        }
        .onAppear(perform:viewModel.fetchReceiptInformation)
        .environmentObject(viewModel)
    }
}

struct ReceiptDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptDetailView(receipt: Receipt(id: 656329, image: "", title: "Pizza bites with pumpkin"))
    }
}
