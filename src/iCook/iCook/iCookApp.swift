//
//  iCookApp.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 12/01/21.
//

import SwiftUI

@main
struct iCookApp: App {
    var body: some Scene {
        WindowGroup {
            ReceiptDetailView(receipt: Receipt(id: 2034789, image: "https://spoonacular.com/recipeImages/656329-556x370.jpg", title: "Pizza bites with pumpkin"))
//            SearchReceiptView(viewModel: SearchReceiptViewModel(searchReceiptApi: SearchReceiptApi()))
        }
    }
}
