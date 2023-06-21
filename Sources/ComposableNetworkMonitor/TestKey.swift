import Foundation
import Dependencies
import XCTestDynamicOverlay
import Network

extension ComposableNetworkMonitor: TestDependencyKey {
  public static let testValue = Self(
    currentPath: unimplemented("\(Self.self).currentPath"),
    observer: unimplemented("\(Self.self).observer")
  )
}

extension ComposableNetworkMonitor {
  public static let noop = Self.init(
    currentPath: { .init(status: .unsatisfied, unsatisfiedReason: .notAvailable) },
    observer: { AsyncStream { _ in } }
  )
}
