import Foundation
import Testing
@testable import PKSCore
import PKSCoreTestSupport

@Suite struct KeychainRoundTripTests {
    @Test func setThenGetReturnsSameData() throws {
        let keychain = InMemoryKeychain()
        let data = Data("secret".utf8)
        try keychain.set(data, account: "token")
        #expect(try keychain.get(account: "token") == data)
    }

    @Test func getMissingAccountReturnsNil() throws {
        let keychain = InMemoryKeychain()
        #expect(try keychain.get(account: "missing") == nil)
    }

    @Test func setOverwritesExistingValue() throws {
        let keychain = InMemoryKeychain()
        try keychain.set(Data("first".utf8), account: "token")
        try keychain.set(Data("second".utf8), account: "token")
        #expect(try keychain.get(account: "token") == Data("second".utf8))
    }

    @Test func deleteRemovesValue() throws {
        let keychain = InMemoryKeychain()
        try keychain.set(Data("secret".utf8), account: "token")
        try keychain.delete(account: "token")
        #expect(try keychain.get(account: "token") == nil)
    }

    @Test func deleteMissingAccountDoesNotThrow() throws {
        let keychain = InMemoryKeychain()
        try keychain.delete(account: "missing")
    }
}
