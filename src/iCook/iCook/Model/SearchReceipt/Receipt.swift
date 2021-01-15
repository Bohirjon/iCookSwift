//
//  Receipt.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 12/01/21.
//

import Foundation

struct Receipt : Codable, Hashable {
    let id:Int
    let image: String
    let title: String
}
