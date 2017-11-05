//
//  STVPlaygroungExtension.swift
//  SchulteTable
//
//  Created by Maxim on 05/11/2017.
//  Copyright © 2017 Maxim. All rights reserved.
//

import Foundation
import CoreGraphics

enum STSizeSegments :Int {
    case STSegmengsNone
    case STSegmengs2x2 = 2
    case STSegmengs3x3 = 3
    case STSegmengs4x4 = 4
    case STSegmengs5x5 = 5
    case STSegmengs6x6 = 6
    case STSegmengs7x7 = 7
}

enum STSymbols {
    case STSymbolsDigits
    case STSymbolsLetter
}

enum STTypeGame {
    case STTypeGameDevelopment
    case STTypeGameClassic
    case STTypeGameLetter
}

extension STVPlaygroung {
    
    func rectPlayground(minimal :CGFloat, segments: STSizeSegments) -> CGRect {
        let sizeValuePlayground = CGFloat(segments.rawValue) * minimal
        let x = (self.bounds.size.width - sizeValuePlayground) / 2
        let y = (self.bounds.size.height - sizeValuePlayground) / 2
        
        return CGRect(x: x, y: y, width: sizeValuePlayground, height: sizeValuePlayground)
    }
    
    func selectSegmentsByCount(_ count :NSInteger) -> STSizeSegments {
        var segment :Int = Int(ceil(sqrt(Double(count))))
        
        if (segment < STSizeSegments.STSegmengs2x2.rawValue) {
            segment = STSizeSegments.STSegmengs2x2.rawValue
        }
        
        if (segment > STSizeSegments.STSegmengs7x7.rawValue) {
            segment = STSizeSegments.STSegmengs7x7.rawValue
        }
        return STSizeSegments(rawValue: segment)!
    }
    
    
    // MARK: - Symbols content
    
    class func contentByCell() -> Array<String> {
        var arr :Array<String>
        
        switch STSettings.typeGame() {
        case STTypeGame.STTypeGameDevelopment:
            arr = STVPlaygroung.createValidArraySymbolsByCount(symbols: STSymbols.STSymbolsDigits, maxCount: STSettings.getMaximalLevel())
            break
        case STTypeGame.STTypeGameClassic:
            arr = STVPlaygroung.createValidArraySymbolsByCount(symbols: STSymbols.STSymbolsDigits, maxCount: 25)
        case STTypeGame.STTypeGameLetter:
            arr = STVPlaygroung.createValidArraySymbolsByCount(symbols: STSymbols.STSymbolsLetter, maxCount: 25)
        }
        return arr
    }
    
    /// for STSymbolsLetter maximal count 26 (a-z), for STSymbolsDigits maximal count 49 (1-49)
    class func createValidArraySymbolsByCount(symbols : STSymbols, maxCount :NSInteger) -> Array<String> {
        
        var arr :Array<String> = Array()
        
        if (symbols == .STSymbolsDigits) {
            arr = self.createArrayDigitsByCount(maxCount <= 49 ? maxCount : 49)
        }
        
        if (symbols == .STSymbolsLetter) {
            arr = self.createArrayCharacterByCount(maxCount <= 26 ? maxCount : 26)
        }
        return arr
    }
    
    
    private class func createArrayDigitsByCount(_ count :NSInteger) -> Array<String> {
        let mutArr :NSMutableArray  = NSMutableArray()
        
        for i in 1...count {
            mutArr.add(String(i))
        }
        
        return Array(mutArr) as! Array<String>
    }
    
    
    private class func createArrayCharacterByCount(_ count:NSInteger) -> Array<String> {
        let mutArr :NSMutableArray  = NSMutableArray()
        
        let aScalars = "a".unicodeScalars
        let aCode :Int = Int(aScalars[aScalars.startIndex].value)
        
        for i in 0..<count {
            mutArr.add(String(Character(UnicodeScalar(Int(aCode + i))!)))
        }
        
        return Array(mutArr) as! Array<String>
    }
}

