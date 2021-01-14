//
//  ContentView.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 12/01/21.
//

import SwiftUI
import Combine

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
                    TextField("Search...", text: $searhKey, onCommit: {
                        print("todo: ViewModel search")
                    }).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        print("todo: ViewModel search")
                    }, label: {
                        Image(systemName: "location.viewfinder")
                    })
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()),
                                        GridItem(.flexible()),
                                        GridItem(.flexible())
                    ],spacing: 12, content: {
                        
                        if viewModel.searchReceiptResult != nil {
                            ForEach(viewModel.searchReceiptResult!.results, id: \.self) { result  in
                                NavigationLink(
                                    destination: Text("ReceiptDetailView"),
                                    label: {
                                        Image(result.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .shadow(radius:1)
                                            .cornerRadius(5.0)
                                            .overlay(RoundedRectangle(cornerRadius: 7.0)
                                                        .stroke(Color.black.opacity(0.4)))
                                    })
                            }
                        } else {
                            VStack(alignment:.trailing) {
                                Text("Search for a receipt")
                                Spacer()
                            }
                            .background(Color.red)
                        }
                        
                    })
                }
                .padding(.vertical, 5)
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
