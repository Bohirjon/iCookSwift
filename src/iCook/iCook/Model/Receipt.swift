//
//  Receipt.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 12/01/21.
//

import Foundation

struct Receipt : Codable {
    let id:Int
    let calories: Int
    let carbs: String
    let fat: String
    let image: String
    let imageType: String
    let protein: String
    let title: String
}
