//
//  ReceiptDetailViewModel.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 15/01/21.
//

import Foundation
import Combine

class ReceiptDetailViewModel: ObservableObject {
    private let receiptId: Int
    private var receiptDetailApi: ReceiptDetailApiProtocol
    
    @Published var receiptInformation:ReceiptInformation? = nil
    @Published var isLoading: Bool = false
    
    init(receiptDetailApi: ReceiptDetailApiProtocol, receiptId: Int) {
        self.receiptDetailApi = receiptDetailApi
        self.receiptId = receiptId
        
        self.receiptDetailApi.receiptDetailDelegate = self
    }
    
    func fetchReceiptInformation() {
        startLoading()
        receiptDetailApi.fetchReceiptInformation(receiptId: receiptId)
    }
}

extension ReceiptDetailViewModel : ReceiptDetailApiDelegate {
    
    func onFetchReceiptInformation(receiptInformation: ReceiptInformation) {
        DispatchQueue.main.async {
            self.receiptInformation = receiptInformation
            self.stopLoading()
        }
    }
    
    func onFailFetchReceiptInformation(error: Error) {
        DispatchQueue.main.async {
            print(error)
            self.stopLoading()
        }
    }
}

extension ReceiptDetailViewModel {
    func startLoading()  {
        isLoading = true
    }
    func stopLoading() {
        isLoading = false
    }
}
