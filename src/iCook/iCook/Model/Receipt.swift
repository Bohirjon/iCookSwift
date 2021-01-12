//
//  Receipt.swift
//  iCook
//
//  Created by Bohirjon Akhmedov on 12/01/21.
//

import Foundation

struct Receipt : Codable {
    let id, calories: Int
    let carbs, fat: String
    let image: String
    let imageType, protein, title: String
}
