import Foundation
import PKSCore

/// Dictionary-backed `KeychainStore` for use in tests, avoiding the real
/// Keychain (which is unavailable/unstable in test hosts and CI).
public final class InMemoryKeychain: KeychainStore, @unchecked Sendable {
    private let lock = NSLock()
    private var storage: [String: Data] = [:]

    public init() {}

    public func get(account: String) throws -> Data? {
        lock.lock()
        defer { lock.unlock() }
        return storage[account]
    }

    public func set(_ data: Data, account: String) throws {
        lock.lock()
        defer { lock.unlock() }
        storage[account] = data
    }

    public func delete(account: String) throws {
        lock.lock()
        defer { lock.unlock() }
        storage.removeValue(forKey: account)
    }
}
