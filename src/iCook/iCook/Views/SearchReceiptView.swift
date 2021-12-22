//
//  ContentView.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 12/01/21.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct Model : Hashable {
    let title :String
    let imageName : String
}

struct SearchReceiptView: View {
    @State private var searhKey = ""
    @ObservedObject var viewModel:SearchReceiptViewModel
    let items:[Model] = (1...19).map {   index  in
        Model(title: "image\(index)", imageName: "This is a title \(index)")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search...", text: $viewModel.searchKey, onCommit: {
                    viewModel.search()
                }).textFieldStyle(RoundedBorderTextFieldStyle())
                if viewModel.searchReceiptResult != nil {
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()),
                                            GridItem(.flexible())
                        ],spacing: 10, content: {
                            
                            ForEach(viewModel.searchReceiptResult!.results, id: \.self) { result  in
                                NavigationLink(
                                    destination:ReceiptDetailView(receipt: result),
                                    label: {
                                        ReceiptResultCell(reciept: result)
                                    })
                            }
                            
                        })
                    }
                    .padding(.vertical, 5)
                } else {
                    VStack(alignment:.trailing) {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 5)
            .navigationBarTitle("Search receipts", displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                //TODO: navigate to the filters view
            }, label: {
                Text("Filter")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let viewModel = SearchReceiptViewModel(searchReceiptApi: SearchReceiptApi())
    
    
    static var previews: some View {
        SearchReceiptView(viewModel: getViewModel())
    }
    
    static func getViewModel() -> SearchReceiptViewModel {
        viewModel.searchKey = "Pizza"
        viewModel.search()
        return viewModel
    }
}
