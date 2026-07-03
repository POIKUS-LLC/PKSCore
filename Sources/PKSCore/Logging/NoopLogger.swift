import Foundation

/// `PKSLogging` implementation that discards every message. Useful as a default
/// so consumers aren't forced to configure logging before using an SDK.
public struct NoopLogger: PKSLogging {
    public init() {}

    public func log(_ level: PKSLogLevel, _ message: @autoclosure () -> String) {}
}
