import Foundation
import Testing
@testable import PKSCore

@Suite struct RFC3339Tests {
    @Test func parsesFractionalSeconds() throws {
        let date = try RFC3339.date(from: "2026-01-02T03:04:05.678Z")
        let components = Calendar(identifier: .gregorian).dateComponents(
            in: TimeZone(identifier: "UTC")!,
            from: date
        )
        #expect(components.year == 2026)
        #expect(components.month == 1)
        #expect(components.day == 2)
        #expect(components.hour == 3)
        #expect(components.minute == 4)
        #expect(components.second == 5)
    }

    @Test func parsesWholeSeconds() throws {
        let date = try RFC3339.date(from: "2026-01-02T03:04:05Z")
        let components = Calendar(identifier: .gregorian).dateComponents(
            in: TimeZone(identifier: "UTC")!,
            from: date
        )
        #expect(components.second == 5)
    }

    @Test func invalidStringThrows() {
        #expect(throws: RFC3339.ParseError.self) {
            try RFC3339.date(from: "not-a-date")
        }
    }

    @Test func stringRoundTripsThroughFractionalFormat() throws {
        let original = try RFC3339.date(from: "2026-01-02T03:04:05.678Z")
        let formatted = RFC3339.string(from: original)
        let reparsed = try RFC3339.date(from: formatted)
        #expect(abs(original.timeIntervalSince(reparsed)) < 0.001)
    }
}
