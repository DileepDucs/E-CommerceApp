//
//  Product.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation

class Product: Object, Decodable {
    
    // MARK: - Properties
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String? = nil
    @objc dynamic var price: String? = nil
    @objc dynamic var description: String? = nil
    @objc dynamic var category: String? = nil
    @objc dynamic var image: String? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case category
        case image
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try? container.decode(String.self, forKey: .title)
        price = try? container.decode(String.self, forKey: .price)
        description = try? container.decode(String.self, forKey: .description)
        category = try? container.decode(String.self, forKey: .category)
        image = try? container.decode(String.self, forKey: .image)
    }
}
