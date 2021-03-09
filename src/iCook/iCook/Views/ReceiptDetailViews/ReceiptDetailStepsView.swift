//
//  ReceiptDetailStepsView.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 15/01/21.
//

import Foundation
import SwiftUI
import Combine

struct ReceiptDetailStepsView: View {
    @EnvironmentObject var viewModel: ReceiptDetailViewModel
    
    var body: some View {
        if viewModel.receiptInformation == nil {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        } else {
            list
        }
    }
    @ViewBuilder
    var list : some View {
        if viewModel.receiptInformation == nil {
            Text("Receiption information is nill")
        } else if (viewModel.receiptInformation!.analyzedInstructions.count > 0) {
            List(viewModel.receiptInformation!.analyzedInstructions[0].steps) { step in
                Text(step.step)
            }
        }
        else {
            Text("collection is empty")
        }
    }
    
}


struct ReceiptDetailStepsView_Previews: PreviewProvider {
    static let viewModel = ReceiptDetailViewModel(receiptDetailApi: ReceipDetialApi(), receiptId: 656329)
    
    static var previews: some View {
        return ReceiptDetailStepsView()
            .environmentObject(viewModel)
    }
}
