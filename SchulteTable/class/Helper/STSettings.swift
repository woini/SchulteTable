//
//  STSettings.swift
//  SchulteTable
//
//  Created by Maxim on 05/11/2017.
//  Copyright © 2017 Maxim. All rights reserved.
//

import Foundation
import UIKit

class STSettings {
    
    private static var maximalLevel :Int = 20
    
    class func colorPlaygroundBack() -> UIColor {
        return UIColor.darkGray
    }
    
    class func colorPlaygroundCellTitle() -> UIColor {
        return UIColor.black
    }
    
    class func colorPlaygroundCellDefault() -> UIColor {
        return UIColor.white
    }
    
    class func colorPlaygroundCellRule() -> UIColor {
        return UIColor.green
    }
    
    class func colorPlaygroundCellWrong() -> UIColor {
        return UIColor.darkGray
    }
    
    class func typeGame() -> STTypeGame {
        return STTypeGame.STTypeGameDevelopment
    }
    
    class func getMaximalLevel() -> Int {
        return STSettings.maximalLevel
    }
    
    class func upMaximalLevel() {
        if (maximalLevel <= 48) {
            STSettings.maximalLevel += 1
        }
    }
    
    class func downMaximalLevel() {
        if (maximalLevel >= 4) {
            STSettings.maximalLevel -= 1
        }
    }
}

