import Foundation
import Network

@available(macOS 11.0, iOS 14.2, watchOS 7.1, tvOS 14.2, *)
public struct ComposableNetworkMonitor {
  public var currentPath: @Sendable () -> Path
  public var observer: @Sendable () -> AsyncStream<Path>

  public struct Path: Equatable {
    public var status: Status
    public var unsatisfiedReason: UnsatisfiedReason
    
    public init(
      status: Status,
      unsatisfiedReason: UnsatisfiedReason
    ) {
      self.status = status
      self.unsatisfiedReason = unsatisfiedReason
    }
    
    public enum Status: Equatable {
      case satisfied
      case unsatisfied
      case requiresConnection
    }
    
    @available(macOS 11.0, iOS 14.2, watchOS 7.1, tvOS 14.2, *)
    public enum UnsatisfiedReason: Equatable {
      case notAvailable
      case cellularDenied
      case wifiDenied
      case localNetworkDenied
    }
  }
}

extension ComposableNetworkMonitor.Path {
  init(rawValue: NWPath) {
    self.status = .init(rawValue: rawValue.status)
    self.unsatisfiedReason = .init(rawValue: rawValue.unsatisfiedReason)
  }
}

extension ComposableNetworkMonitor.Path.Status {
  init(rawValue: NWPath.Status) {
    switch rawValue {
    case .satisfied: self = .satisfied
    case .unsatisfied: self = .unsatisfied
    case .requiresConnection: self = .requiresConnection
    @unknown default: self = .satisfied
    }
  }
}

extension ComposableNetworkMonitor.Path.UnsatisfiedReason {
  init(rawValue: NWPath.UnsatisfiedReason) {
    switch rawValue {
    case .notAvailable: self = .notAvailable
    case .cellularDenied: self = .cellularDenied
    case .wifiDenied: self = .wifiDenied
    case .localNetworkDenied: self = .localNetworkDenied
    default: self = .notAvailable
    }
  }
}
