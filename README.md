# PKSCore

Zero-dependency foundation package for Poikus iOS SDKs: Keychain access, logging,
money handling, and RFC 3339 date/JSON coding.

## Requirements

- iOS 16+ / macOS 13+
- Swift 6

## Installation

```swift
.package(url: "https://github.com/POIKUS-LLC/PKSCore.git", .upToNextMinor(from: "0.1.0"))
```

## API

```swift
import PKSCore

// Keychain
let keychain: KeychainStore = SystemKeychain(service: "com.example.app")
try keychain.set(Data("secret".utf8), account: "token")
let value = try keychain.get(account: "token")

// Logging
let logger: PKSLogging = OSLogAdapter(subsystem: "com.example.app", category: "network")
logger.log(.info, "started")

// Money
let amount = Micros(1_500_000) // 1.5 in major units
amount.decimalValue // 1.5

// Dates
let date = try RFC3339.date(from: "2026-01-02T03:04:05.678Z")
```

## License

Apache-2.0
