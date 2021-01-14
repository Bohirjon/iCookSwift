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
    
    func search(queryKey: String, number: Int) {
        let urlString = "\(AppConstract.ReceiptServiceEndPoint)?query=\(queryKey)&number=\(number.description)"
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let safeData = data  {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let searchReceiptResult  = try jsonDecoder.decode(SearchReceiptResult.self, from: safeData)
                        self.searchReceiptApiDelegate?.onSearchFinish(searchReceiptResult: searchReceiptResult)
                    } catch let error {
                        self.searchReceiptApiDelegate?.onSearchFailed(error: error)
                    }
                }
            }.resume()
            
        } else {
            print("bad url: = \(urlString)")
            self.searchReceiptApiDelegate?.onSearchFailed(error: URLError.init(.badURL))
        }
    }
}
