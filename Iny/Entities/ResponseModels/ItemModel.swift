//
//  ItemModel.swift
//  Iny
//
//  Created by Deniz Dilbilir on 08/04/2024.
//

import Foundation

struct ItemModel: Codable {
    let id: Int
    let title: String
    let price: Float
    let category: String
    let description: String
    let image: String
}
