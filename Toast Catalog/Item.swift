import Foundation

struct Item: Identifiable, Hashable, Codable {
    let name: String
    let price: String
    let id: Int
    let last_sold: String 
}
