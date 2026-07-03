import Foundation

/// Integer-micros money representation (1 major unit == 1_000_000 micros).
/// Matches the backend's `AmountMicros int64` wire format exactly, avoiding
/// floating-point rounding for currency values.
public struct Micros: Codable, Hashable, Comparable, Sendable {
    public let value: Int64

    public init(_ value: Int64) {
        self.value = value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try container.decode(Int64.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    public static func < (lhs: Micros, rhs: Micros) -> Bool {
        lhs.value < rhs.value
    }

    /// Major-unit decimal value, e.g. `1_500_000` micros -> `1.5`.
    public var decimalValue: Decimal {
        Decimal(value) / 1_000_000
    }

    /// Locale-aware currency string, e.g. "$1.50" for the "USD" currency code.
    public func formatted(currencyCode: String, locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.locale = locale
        return formatter.string(from: decimalValue as NSDecimalNumber) ?? "\(decimalValue) \(currencyCode)"
    }
}
