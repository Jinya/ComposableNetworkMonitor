import Foundation
import Dependencies
import Network
import Combine

extension ComposableNetworkMonitor: DependencyKey {
  public static let liveValue: Self = {
    let monitor = NWPathMonitor(requiredInterfaceType: .loopback)
    monitor.start(queue: DispatchQueue(label: "\(Self.self)"))
    let subject = CurrentValueSubject<Self.Path, Never>(.init(rawValue: monitor.currentPath))
    return Self(
      currentPath: { subject.value },
      observer: {
        monitor.pathUpdateHandler = {
          subject.send(.init(rawValue: $0))
        }
        return AsyncStream { continuation in
          let cancellable = subject
            .removeDuplicates()
            .sink { continuation.yield($0) }

          continuation.onTermination = { _ in
            cancellable.cancel()
            monitor.cancel()
          }
        }
      }
    )
  }()
}
