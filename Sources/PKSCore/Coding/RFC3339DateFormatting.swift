import Foundation

/// RFC 3339 date parsing/formatting matching the backend's `time.Time` JSON
/// marshaling, which may or may not include fractional seconds.
public enum RFC3339 {
    // ISO8601DateFormatter instances are safe to share across threads once
    // `formatOptions` is fixed at init and never mutated afterward.
    nonisolated(unsafe) private static let fractional: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    nonisolated(unsafe) private static let whole: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    public enum ParseError: Error, Sendable, Equatable {
        case invalidFormat(String)
    }

    public static func date(from string: String) throws -> Date {
        if let date = fractional.date(from: string) {
            return date
        }
        if let date = whole.date(from: string) {
            return date
        }
        throw ParseError.invalidFormat(string)
    }

    /// Always emits fractional seconds on output.
    public static func string(from date: Date) -> String {
        fractional.string(from: date)
    }
}
