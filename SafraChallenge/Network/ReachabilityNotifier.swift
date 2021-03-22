//
//  ReachabilityNotifier.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 22/02/21.
//

import Foundation
import UIKit
import Reachability

protocol ReachabilityNotifierDelegate {
    func callReachabilityScreen(status: Reachability.Connection)
}

class ReachabilityNotifier {
    static let instance = ReachabilityNotifier()
    
    var delegate: ReachabilityNotifierDelegate?
    
    var isNetworkAvailable : Bool {
        self.reachability = try? Reachability()

        if let reachability = self.reachability {
            return reachability.connection != .unavailable
        }
        return true
    }
    
    var reachabilityStatus: Reachability.Connection = .unavailable
    
    var reachability: Reachability?
    
    private init() {
        self.reachability = try? Reachability()
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        
        switch reachability.connection {
        case .unavailable:
            RGLog.d("Rede não conectada!")
        case .wifi:
            RGLog.d("Rede conectado por WiFi!")
        case .cellular:
            RGLog.d("Rede conectado por rede de dados do Celular!")
        case .none:
            RGLog.d("Rede não conectada!")
        }
        
        self.reachabilityStatus = reachability.connection
    }

    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        guard let reachability = reachability else {
            RGLog.w("Reachability não iniciado!")
            return
        }
        
        do{
            try reachability.startNotifier()
            self.reachabilityStatus = reachability.connection
        } catch {
            RGLog.d("Não foi possível iniciar o NOTIFIER do Reachability!")
        }
    }
}
