///  ** Credits **
/// Created by Emre Kucukayvaz
/// Github: https://gist.github.com/emrekyv/39f4ad01157899e5f40e2ab9d66e6b20


import CoreLocation
import Foundation

public struct Job: Decodable {
    public let clientName: String
    public let imageURL: URL?
    public let category: String
    public let address: Address
    
    
    public init(
        clientName: String,
        imageURL: URL?,
        category: String,
        address: Address)
      {
        self.clientName = clientName
        self.imageURL = imageURL
        self.category = category
        self.address = address
    }
    
}
 
extension Job {
    
    enum CodingKeys: String, CodingKey {
        case title
        case project
        case category
        case address = "report_at_address"
    }

    enum ProjectKeys: String, CodingKey {
        case client
    }

    enum ClientKeys: String, CodingKey {
        case name
        case links
    }

    enum LinksKeys: String, CodingKey {
        case heroImage = "hero_image"
    }

    enum CategoryKeys: String, CodingKey {
        case nameTranslation = "name_translation"
    }

    enum NameTranslationKeys: String, CodingKey {
        case english = "en_GB"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let projectValues = try values.nestedContainer(keyedBy: ProjectKeys.self, forKey: .project)
        let clientValues = try projectValues.nestedContainer(keyedBy: ClientKeys.self, forKey: .client)
        let linksValues = try? clientValues.nestedContainer(keyedBy: LinksKeys.self, forKey: .links)
        let categoryValues = try values.nestedContainer(keyedBy: CategoryKeys.self, forKey: .category)
        let nameTranslationValues = try categoryValues.nestedContainer(keyedBy: NameTranslationKeys.self, forKey: .nameTranslation)
        address = try values.decode(Address.self, forKey: .address)
        clientName = try clientValues.decode(String.self, forKey: .name)
        category = try nameTranslationValues.decode(String.self, forKey: .english)
        imageURL = try linksValues?.decode(URL.self, forKey: .heroImage)
    }
}

public struct Address: Decodable {
    public let coordinate: CLLocation
    
    public init(coordinate: CLLocation) {
        self.coordinate = coordinate
    }
    
}

extension Address {
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "geo"
    }

    enum CoordinateKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let coordinateValues = try values.nestedContainer(keyedBy: CoordinateKeys.self, forKey: .coordinates)
        let latitude = try coordinateValues.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try coordinateValues.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocation(latitude: latitude, longitude: longitude)
    }
}

enum Currency {
    case euro
    case unitedStatesDollar
    case unknown
    init(shorthand: String) {
        switch shorthand {
        case "EUR":
            self = .euro
        case "USD":
            self = .unitedStatesDollar
        default:
            self = .unknown
        }
    }

    var sign: String {
        switch self {
        case .euro:
            return "€"
        case .unitedStatesDollar:
            return "$"
        case .unknown:
            return "?"
        }
    }
}


extension Job : Equatable {}
extension Address  :Equatable {}

