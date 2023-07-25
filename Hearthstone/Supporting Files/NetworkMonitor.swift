//
//  NetworkMonitor.swift
//  Hearthstone
//
//  Created by NJ Development on 21/07/23.
//

import Network
import UIKit

// final class Network {
//    public private(set) var isConnected: Bool = false
//    static func monitorNetwork() {
//        let monitor = NWPathMonitor()
//        monitor.pathUpdateHandler = { path in
//            if path.status == .satisfied {
//                print("INTERNET ON")
//            } else {
//                print("INTERNET OFF")
//            }
//        }
//        
//        let queue = DispatchQueue(label: "Network")
//        monitor.start(queue: queue)
//    }
// }

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor: NWPathMonitor

    enum NetworkStatus {
        case internetOn
        case internetOff
        case unknown
    }

    private(set) var isConnected = false
    private(set) var networkStatus: NetworkStatus = .unknown

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }

        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }

    private func getNetworkStatus(_ path: NWPath) -> NetworkStatus {
        if path.status == .satisfied {
            return .internetOn
        } else {
            return .internetOff
        }
    }
}
