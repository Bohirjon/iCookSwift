//
//  File.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 15/01/21.
//

import Foundation
import SwiftUI
import Combine

struct ReceiptDetailIngredientsView : View {
    @EnvironmentObject var viewModel: ReceiptDetailViewModel
    
    var body: some View {
        Text("Placeholder")
    }
}


struct ReceiptDetailIngredientsView_Previews: PreviewProvider {
    static let viewModel = ReceiptDetailViewModel(receiptDetailApi: ReceipDetialApi(), receiptId: 656329)
    
    static var previews: some View {
        print("creating")
        viewModel.fetchReceiptInformation()
        return ReceiptDetailIngredientsView()
            .environmentObject(viewModel)
    }
}
