//
//  SearchReceiptResult.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 12/01/21.
//

import Foundation

struct SearchReceiptResult : Codable{
    let offset, number: Int
    let results: [Receipt]
    let totalResults: Int
}
