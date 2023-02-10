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
        TabView {
            ReceiptDetailOverviewView()
                .tabItem {
                    Label("Overview", systemImage: "book.fill")
                }
            NavigationView(){
                ReceiptDetailIngredientsView()
            }
            .tabItem {
                Label("Ingredients", systemImage: "cart.fill")
            }
            NavigationView() {
                ReceiptDetailStepsView()
            }
            .tabItem {
                Label("Steps",systemImage: "dial.max")
            }
            
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
