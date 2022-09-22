///  ** Credits **
/// Created by Emre Kucukayvaz
/// Github: https://gist.github.com/emrekyv/39f4ad01157899e5f40e2ab9d66e6b20


import Foundation

public struct ShiftsResponse: Decodable {
    let data: [Shift]
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case data
        case count = "aggregations"
    }
    
    enum AggregationsKeys: String, CodingKey {
        case count
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let aggregationsValues = try values.nestedContainer(keyedBy: AggregationsKeys.self, forKey: .count)
        
        data = try values.decode([Shift].self, forKey: .data)
        count = try aggregationsValues.decode(Int.self, forKey: .count)
    }
}
