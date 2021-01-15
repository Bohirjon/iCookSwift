//
//  SearchReceiptError.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 15/01/21.
//

import Foundation

struct SearchReceiptError : Error {
    let message: String
    let queryKey : String?
}
