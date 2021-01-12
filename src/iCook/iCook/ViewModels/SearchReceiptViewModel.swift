//
//  SearchReceiptViewModel.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 12/01/21.
//

import Foundation
import Combine

class SearchReceiptViewModel: ObservableObject {
    private let searchReceiptApi: SearchReceiptApiProtocol
    
    @Published var searchReceiptResult: SearchReceiptResult? = nil
    @Published var searchKey: String?
    
    
    init(searchReceiptApi: SearchReceiptApiProtocol) {
        self.searchReceiptApi = searchReceiptApi
    }
    
    func search(queryKey: String)  {
        searchReceiptApi .search(queryKey: queryKey, number: 20)
    }
}

extension SearchReceiptViewModel : SearchReceiptApiDelegate {
    func onSearchFinish(searchReceiptResult: SearchReceiptResult) {
        self.searchReceiptResult = searchReceiptResult
    }
    
    func onSearchFailed(error: Error) {
        print(error)
    }
}
