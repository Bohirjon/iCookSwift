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
    var searchReceiptApiDelegate: SearchReceiptApiDelegate! { get }
    func search(queryKey: String)
}

class SearchReceiptApi: SearchReceiptApiProtocol {
    let searchReceiptApiDelegate: SearchReceiptApiDelegate!
   
    init(searchReceiptApiDelegate: SearchReceiptApiDelegate) {
        self.searchReceiptApiDelegate = searchReceiptApiDelegate
    }
    
    func search(queryKey: String) {
        
    }
}
