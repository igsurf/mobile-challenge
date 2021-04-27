//
//  FBModel.swift
//  FBModel
//
//  Created by Felipe Correia Brito on 16/09/20.
//  Copyright © 2020 Felipe Correia Brito. All rights reserved.
//

import Foundation

/// Represents the model layer on MVC and MVVM patterns
public protocol FBModel: Codable, Equatable {
    /// JSON string representation of the Model
    var JSON: String { get }
    
    /// Dictionary representation of the Model
    var dictionary: [String: AnyObject] { get }
    
    /// Generates the model from a JSON representation in string.
    /// Returns nil if not possible
    /// - Parameter json: string in json format to parse this model
    static func from(_ json: String) -> Self?
    
    /// Generates the model from a JSON representation in Data.
    /// - Parameter data: the data representation of some json string to parse this model
    static func from(_ data: Data) -> Self?
}

// Codable conformance
public extension FBModel {
    fileprivate var jsonData: Data {
        get {
            let encoder = JSONEncoder()
            
            do {
                return try encoder.encode(self)
            } catch {
                print(error)
                return Data()
            }
        }
    }
    // The default implementation just catch the data from codable and then translate it to JSON
    var JSON: String {
        get {
            return String(data: self.jsonData, encoding: .utf8) ?? ""
        }
    }
    
    var dictionary: [String: AnyObject] {
        get {
            guard let data = JSON.data(using: .utf8) else { return [:] }
            guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else { return [:] }
            return dict
        }
    }
    
    // The default implementation just take a json string and tries to generate.
    static func from(_ json: String) -> Self? {
        guard let data = json.data(using: .utf8) else { return nil }
        return from(data)
    }
    
    static func from(_ data: Data) -> Self? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(self, from: data)
        } catch {
            print("Parser error on FBModel ::: \(self) ::: ", error.localizedDescription)
            return nil
        }
    }
}

// Equatable conformance
public extension FBModel {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.JSON == rhs.JSON
    }
}

// Implementing decode and encode of lists
public extension Array where Element: FBModel {
    /// Generate the array model from a JSON representation in String
    /// - Parameter json: json representation of model in string format
    /// - Returns: A list of the encoded elements in json or nil if not possible
    static func from(_ json: String) -> [Element]? {
        guard let data = json.data(using: .utf8) else { return nil }
        return from(data)
    }
    
    /// Generates the model from a JSON representation in Data
    /// - Parameter data: json representation of model in data format
    /// - Returns: a list of the encoded elements in json or nil if not possible
    static func from(_ data: Data) -> [Element]? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(self, from: data)
        } catch {
            print("Parser error on FBModel ::: \(self) ::: ", error.localizedDescription)
            return nil
        }
    }
    
    /// JSON data representation of the Model list
    fileprivate var jsonData: Data {
        get {
            let encoder = JSONEncoder()
            
            do {
                return try encoder.encode(self)
            } catch {
                print(error)
                return Data()
            }
        }
    }
    
    /// JSON string representation of the Model list
    var JSON: String {
        return String(data: self.jsonData, encoding: .utf8) ?? ""
    }
}
