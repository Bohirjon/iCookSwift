//
//  MockReceipDetailApi.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 18/01/21.
//

import Foundation

class MockReceiptDetailApi: ReceiptDetailApiProtocol {
    var receiptDetailDelegate: ReceiptDetailApiDelegate?
    
    func fetchReceiptInformation(receiptId: Int) {
        
        if let path = Bundle.main.path(forResource: "receipt", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let jsonDecoder = JSONDecoder()
                let receiptInformation = try jsonDecoder.decode(ReceiptInformation.self, from: data)
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                    self.receiptDetailDelegate?.onFetchReceiptInformation(receiptInformation: receiptInformation)
                }
            }
            catch let error {
                self.receiptDetailDelegate?.onFailFetchReceiptInformation(error: error)
            }
        }
    }
}
