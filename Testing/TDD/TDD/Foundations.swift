//
//  Foundations.swift
//  TDD
//
//  Created by Jastin on 15/7/23.
//

import UIKit


final class Foundations {
    
    private (set) var area: Int
    
    var width: Int {
        didSet {
            self.area = self.width * self.width
            self.drawSquare(width: width, color: redOrGreen(for: width))
        }
    }
    
    init() {
        self.area = 0
        self.width = 0
    }
    
    private func redOrGreen(for: Int) -> UIColor {
        return width % 2 == 0 ? .red : .green
    }
    
    private func drawSquare(width: Int, color: UIColor) {
        
    }
    
    /// CommaSeparated
    /// - Parameters:
    ///   - from: any number
    ///   - to: any number
    /// - Returns: a string with value separated by comma
    ///  Testing Loop Converage 
    static func commaSeparated(from: Int, to: Int) -> String {
        var result = ""
        for n in from..<to {
            result.append("\(n),")
        }
        result.append("\(to)")
        return result
    }
    
    static func numberToString(_ value: Int) -> String {
        guard value != 0 else {
            return ""
        }
        
        guard String(value).count > 1 else {
            return String(value)
        }
        
        guard let xValue = String(value).first, xValue.isNumber else {
            if String(value).count == 2 {
                return String(value)
            } else {
                return "-" + String(value)
                    .replacingOccurrences(of: "-", with: "")
                    .split(separator: "")
                    .joined(separator: ",-")
            }
        }
        
        return String(value).split(separator: "").joined(separator: ",")
    }
}
