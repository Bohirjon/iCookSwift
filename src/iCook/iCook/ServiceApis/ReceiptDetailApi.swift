//
//  ReceiptDetailApi.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 15/01/21.
//

import Foundation

protocol ReceiptDetailApiDelegate {
    func onFetchReceiptInformation(receiptInformation: ReceiptInformation)
    func onFailFetchReceiptInformation(error:Error)
}

protocol ReceiptDetailApiProtocol {
    var receiptDetailDelegate: ReceiptDetailApiDelegate? {get set}
    func fetchReceiptInformation(receiptId: Int)
}

class ReceipDetialApi: ReceiptDetailApiProtocol  {
    var receiptDetailDelegate: ReceiptDetailApiDelegate?
    
    func fetchReceiptInformation(receiptId: Int) {
        let stringUrl = "\(AppConstract.ReceiptServiceEndPoint)\(receiptId.description)/information?includeNutrition=false&apiKey=\(AppConstract.ApiKey)"
        if let url = URL(string: stringUrl) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let safeError = error {
                    self.receiptDetailDelegate?.onFailFetchReceiptInformation(error: safeError)
                    print(safeError)
                    return
                } else {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let receiptInformation =  try jsonDecoder.decode(ReceiptInformation.self, from: data!)
                        self.receiptDetailDelegate?.onFetchReceiptInformation(receiptInformation: receiptInformation)
                    } catch let decodeError {
                        self.receiptDetailDelegate?.onFailFetchReceiptInformation(error: decodeError)
                    }
                }
            }
            .resume()
            
        } else {
            receiptDetailDelegate?.onFailFetchReceiptInformation(error: URLError(.badURL))
            print(stringUrl)
            return
        }
    }
}
