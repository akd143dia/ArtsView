import Foundation
import UIKit

struct Artwork {
    let id: Int
    let title: String
    let desc: String
    let thumbUrl: URL
   var thumb: UIImage?
}


extension Artwork: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case thumbUrl = "thumbUrl"
        case desc = "description"
        
        }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        desc = try container.decode(String.self, forKey: .desc)

        thumbUrl = try container.decode(URL.self, forKey: .thumbUrl)
      
    }
}
