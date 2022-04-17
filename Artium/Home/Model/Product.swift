//
//  Product.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation

struct Product: Codable {
    var id: Int = 0
    var title: String? = nil
    var price: Double = 0
    var description: String? = nil
    var category: String? = nil
    var image: String? = nil
    var rating: Rating? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case category
        case image
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        price = try values.decode(Double.self, forKey: .price)
        description = try values.decode(String.self, forKey: .description)
        category = try values.decode(String.self, forKey: .category)
        image = try values.decode(String.self, forKey: .image)
        rating = try values.decode(Rating.self, forKey: .rating)
    }
}

struct Rating: Codable {
    var rate: Double = 0
    var count: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case rate
        case count
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rate = try values.decode(Double.self, forKey: .rate)
        count = try values.decode(Int.self, forKey: .count)
    }
}

