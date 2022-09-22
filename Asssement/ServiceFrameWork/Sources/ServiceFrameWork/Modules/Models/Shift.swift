///  ** Credits **
/// Created by Emre Kucukayvaz
/// Github: https://gist.github.com/emrekyv/39f4ad01157899e5f40e2ab9d66e6b20

import Foundation

public struct Shift: Decodable {
    
    public let id: String
    public let startsAt: Date
    public let endsAt: Date
    public let earningsPerHour: String
    public let job: Job

    static var isoDateFormatter = ISO8601DateFormatter()

    public init(
        id: String,
        startsAt: Date,
        endsAt: Date,
        earningsPerHour: String,
        job: Job) {
        self.id = id
        self.startsAt = startsAt
        self.endsAt = endsAt
        self.earningsPerHour = earningsPerHour
        self.job = job
    }
}

extension Shift {
    
    enum CodingKeys: String, CodingKey {
        case id
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case earningsPerHour = "earnings_per_hour"
        case job
    }

    enum EarningsPerHourKeys: String, CodingKey {
        case currency
        case amount
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        guard let startsAtValue = Shift.isoDateFormatter.date(from: try values.decode(String.self, forKey: .startsAt)) else {
            throw DecodingError.dataCorruptedError(forKey: .startsAt, in: values, debugDescription: "Expecting a valid date format")
        }
        startsAt = startsAtValue
        guard let endsAtValue = Shift.isoDateFormatter.date(from: try values.decode(String.self, forKey: .endsAt)) else {
            throw DecodingError.dataCorruptedError(forKey: .startsAt, in: values, debugDescription: "Expecting a valid date format")
        }
        endsAt = endsAtValue
        let earningsPerHourValues = try values.nestedContainer(keyedBy: EarningsPerHourKeys.self, forKey: .earningsPerHour)
        let earningsPerHourCurrencyValue = try earningsPerHourValues.decode(String.self, forKey: .currency)
        let earningsPerHourAmountValue = try earningsPerHourValues.decode(Double.self, forKey: .amount)
        earningsPerHour = "\(Currency(shorthand: earningsPerHourCurrencyValue).sign) \(earningsPerHourAmountValue)"
        job = try values.decode(Job.self, forKey: .job)
    }
}

extension Shift: Equatable {}
