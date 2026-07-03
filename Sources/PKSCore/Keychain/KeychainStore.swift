import Foundation

/// Abstraction over a persistent, secret-safe key-value store.
public protocol KeychainStore: Sendable {
    func get(account: String) throws -> Data?
    func set(_ data: Data, account: String) throws
    func delete(account: String) throws
}

public enum KeychainError: Error, Sendable, Equatable {
    case unhandled(status: OSStatus)
}
