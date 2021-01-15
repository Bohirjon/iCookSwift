//
//  SearchReceiptViewModel.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 12/01/21.
//

import Foundation
import Combine

class SearchReceiptViewModel: ObservableObject {
    var searchReceiptApi: SearchReceiptApiProtocol
    
    @Published var searchReceiptResult: SearchReceiptResult? = nil
    @Published var searchKey: String = ""
    @Published var isLoading: Bool = false
    
    init(searchReceiptApi: SearchReceiptApiProtocol) {
        self.searchReceiptApi = searchReceiptApi
        self.searchReceiptApi.searchReceiptApiDelegate = self
    }
    
    func search()  {
        startLoading()
        searchReceiptApi.search(queryKey: searchKey, number: 100)
    }
}

extension SearchReceiptViewModel : SearchReceiptApiDelegate {
    
    func onSearchFinish(searchReceiptResult: SearchReceiptResult) {
        DispatchQueue.main.async {
            self.searchReceiptResult = searchReceiptResult
            self.stopLoading()
        }
    }
    
    func onSearchFailed(error: Error) {
        DispatchQueue.main.async {
            self.stopLoading()
        }
    }
}

extension SearchReceiptViewModel {
    func startLoading()  {
        isLoading = true
    }
    func stopLoading() {
        isLoading = false
    }
}
