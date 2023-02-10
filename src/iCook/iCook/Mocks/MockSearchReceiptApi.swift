//
//  MockSearchReceiptApi.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 21/01/21.
//

import Foundation


class MockSearchReceiptApi: SearchReceiptApiProtocol {
    var searchReceiptApiDelegate: SearchReceiptApiDelegate?
    let jsonDecoder  = JSONDecoder()
    
    
    func search(queryKey: String, number: Int) {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let jsonDecoder = JSONDecoder()
                let searchReceiptResult = try jsonDecoder.decode(SearchReceiptResult.self, from: data)
                
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                    self.searchReceiptApiDelegate?.onSearchFinish(searchReceiptResult: searchReceiptResult)
                }
            } catch let decodeError {
                print(decodeError)
            }
        } else {
            self.searchReceiptApiDelegate?.onSearchFailed(error: SearchReceiptError(message: "Could not find the json fille", queryKey: queryKey))
        }
    }
}
