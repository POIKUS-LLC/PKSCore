import Foundation

public enum PKSLogLevel: Int, Sendable, Comparable {
    case debug
    case info
    case warning
    case error

    public static func < (lhs: PKSLogLevel, rhs: PKSLogLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

/// Logging seam so downstream packages never depend on a concrete logging framework.
public protocol PKSLogging: Sendable {
    func log(_ level: PKSLogLevel, _ message: @autoclosure () -> String)
}
