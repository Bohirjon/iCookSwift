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
                HStack {
                    TextField("Search...", text: $viewModel.searchKey, onCommit: {
                        viewModel.search()
                    }).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        viewModel.search()
                    }, label: {
                        Image(systemName: "location.viewfinder")
                    })
                    
                }
                if viewModel.searchReceiptResult != nil {
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()),
                                            GridItem(.flexible()),
                                            GridItem(.flexible())
                        ],spacing: 12, content: {
                            
                            
                            ForEach(viewModel.searchReceiptResult!.results, id: \.self) { result  in
                                NavigationLink(
                                    destination: Text("ReceiptDetailView"),
                                    label: {
                                        WebImage(url: URL(string: result.image))
                                            .onSuccess(perform: { (image) in
                                                let index = viewModel.searchReceiptResult!.results.firstIndex(of: result)
                                                print(index!)
                                            })
                                            .resizable()
                                            .indicator(.activity)
                                            .transition(.fade(duration: 0.5))
                                            .aspectRatio(contentMode: .fill)
                                            .shadow(radius:1)
                                            .cornerRadius(5.0)
                                            .overlay(RoundedRectangle(cornerRadius: 7.0)
                                                        .stroke(Color.black.opacity(0.4)))
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
                        } else {
                            Text("Search for a receipt")
                                .foregroundColor(Color.black.opacity(0.7))
                                .font(.caption)
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 5)
            .navigationBarTitle("Search receipts", displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                //TODO: navigate to the filters view
            }, label: {
                Text("Filters")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchReceiptView(viewModel: SearchReceiptViewModel(searchReceiptApi: SearchReceiptApi()))
    }
}
