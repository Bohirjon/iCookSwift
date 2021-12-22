//
//  ReceiptResultCell.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 03/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReceiptResultCell: View {
    let reciept: Receipt
    
    var body: some View {
        GroupBox {
            VStack {
                WebImage(url: URL(string: reciept.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(3.0)
                    .shadow(color: .gray, radius: 5, x: 0.0, y: 1.0)
                    .padding()
                
                Text(reciept.title)
                
            }
        }
        
    }
}

struct ReceiptResultCell_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptResultCell(reciept:
                            Receipt(id: 12, image: "https://www.italian-feelings.com/wp-content/uploads/2019/10/PIAZZA-940x627.jpg" , title: "Pizza italiano"))
    }
}
