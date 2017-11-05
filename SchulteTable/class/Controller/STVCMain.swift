//
//  STVCMain.swift
//  SchulteTable
//
//  Created by Maxim on 05/11/2017.
//  Copyright © 2017 Maxim. All rights reserved.
//

import Foundation
import UIKit

class STVCMain: UIViewController, STVPlaygroungDelegate {
    
    @IBOutlet var playgroung :STVPlaygroung?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.playgroung?.playgroungDelegate = self
        self.playgroung?.fillContent()
    }


    @IBAction public func ibaPreviewCell(button :UIButton) {
        self.playgroung?.selectPreviewCell()
    }


    @IBAction public func ibaNextCell(button :UIButton) {
        self.playgroung?.selectNextCell()
    }


    func didPlaygroungRuleCell() {
        //        Swift.print(self.self, #function, #line, ":", self)
    }


    func didPlaygroungWrongCell() {
        STSettings.downMaximalLevel()
        self.playgroung?.fillContent()
    }


    func didPlaygroungFinished() {
        STSettings.upMaximalLevel()
        self.playgroung?.fillContent()
    }
}
