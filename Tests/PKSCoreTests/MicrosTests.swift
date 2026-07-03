import Foundation
import Testing
@testable import PKSCore

@Suite struct MicrosTests {
    @Test func decimalValueConvertsMicrosToMajorUnits() {
        #expect(Micros(1_500_000).decimalValue == Decimal(string: "1.5"))
        #expect(Micros(0).decimalValue == 0)
        #expect(Micros(-2_000_000).decimalValue == -2)
    }

    @Test func comparable() {
        #expect(Micros(100) < Micros(200))
        #expect(!(Micros(200) < Micros(100)))
    }

    @Test func codableRoundTrip() throws {
        let original = Micros(1_234_567)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Micros.self, from: data)
        #expect(decoded == original)
    }

    @Test func formattedProducesNonEmptyString() {
        let text = Micros(1_500_000).formatted(currencyCode: "USD", locale: Locale(identifier: "en_US"))
        #expect(!text.isEmpty)
    }
}
