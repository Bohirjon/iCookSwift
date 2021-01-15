//
//  SearchReceiptApi.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 12/01/21.
//

import Foundation


protocol SearchReceiptApiDelegate {
    func onSearchFinish(searchReceiptResult: SearchReceiptResult)
    func onSearchFailed(error: Error)
}

protocol SearchReceiptApiProtocol {
    var searchReceiptApiDelegate: SearchReceiptApiDelegate? { get set }
    func search(queryKey: String, number: Int)
}

class SearchReceiptApi: SearchReceiptApiProtocol {
    var searchReceiptApiDelegate: SearchReceiptApiDelegate?
    let jsonDecoder  = JSONDecoder()
    
    
    func search(queryKey: String, number: Int) {
        let urlString = "\(AppConstract.ReceiptServiceEndPoint)complexSearch?apiKey=\(AppConstract.ApiKey)&query=\(queryKey)&number=\(number.description)"
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let safeError = error {
                    self.searchReceiptApiDelegate?.onSearchFailed(error: safeError)
                    return
                }
                
                if let safeResult = self.parseJson(data: data!) {
                    self.searchReceiptApiDelegate?.onSearchFinish(searchReceiptResult: safeResult)
                } else {
                    self.searchReceiptApiDelegate?.onSearchFailed(error: SearchReceiptError(message: "Could not decode the json!", queryKey: queryKey))
                }
                
            }.resume()
            
        } else {
            print("bad url: = \(urlString)")
            self.searchReceiptApiDelegate?.onSearchFailed(error: URLError.init(.badURL))
        }
    }
    
    func parseJson(data: Data) -> SearchReceiptResult? {
        do {
            let result = try jsonDecoder.decode(SearchReceiptResult.self, from: data)
            return result
        } catch let error {
            print(error)
            return nil
        }
    }
}
