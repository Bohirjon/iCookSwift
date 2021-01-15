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
            ReceiptDetailView(receipt: Receipt(id: 656329, image: "", title: "Pizza bites with pumpkin"))
        }
    }
}
