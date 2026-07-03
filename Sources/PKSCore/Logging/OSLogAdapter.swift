import Foundation
import os

/// `os.Logger`-backed `PKSLogging` implementation.
public struct OSLogAdapter: PKSLogging {
    private let logger: Logger
    private let minimumLevel: PKSLogLevel

    public init(subsystem: String, category: String, minimumLevel: PKSLogLevel = .debug) {
        self.logger = Logger(subsystem: subsystem, category: category)
        self.minimumLevel = minimumLevel
    }

    public func log(_ level: PKSLogLevel, _ message: @autoclosure () -> String) {
        guard level >= minimumLevel else { return }
        let text = message()
        switch level {
        case .debug:
            logger.debug("\(text, privacy: .public)")
        case .info:
            logger.info("\(text, privacy: .public)")
        case .warning:
            logger.warning("\(text, privacy: .public)")
        case .error:
            logger.error("\(text, privacy: .public)")
        }
    }
}
