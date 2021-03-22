//
//  RGLog.swift
//  SafraChallenge
//
//  Created by Ruan Gustavo de Oliveira on 21/02/21.
//

import Foundation



enum LogType: String {
    case ERROR = "E"
    case WARNING = "W"
    case INFO = "I"
    case DEBUG = "D"
}

public class RGLog {
    #if DEBUG
        private static let isDebug: Bool = true
    #else
        private static let isDebug: Bool = false
    #endif
    
    private static var appName: String {
        return "SafraChallenge"
    }
    
    public static func e(_ message: String) {
        print(message, type: LogType.ERROR)
    }
    
    public static func w(_ message: String) {
        print(message, type: LogType.WARNING)
    }
    
    public static func i(_ message: String) {
        print(message, type: LogType.INFO)
    }
    
    public static func d(_ message: String) {
        if !isDebug { return }
        print(message, type: LogType.DEBUG)
    }
    
    public static func d(_ error: Error) {
        if !isDebug { return }
        debugPrint("[\(appName)]\(LogType.DEBUG): \(error)")
    }
    
    private static func print(_ message: String, type: LogType) {
        debugPrint("[\(appName)]\(type.rawValue): \(message)")
    }
}
