//
//  STVPlaygroung.swift
//  SchulteTable
//
//  Created by Maxim on 05/11/2017.
//  Copyright © 2017 Maxim. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics


protocol STVPlaygroungDelegate {
    func didPlaygroungRuleCell()
    func didPlaygroungWrongCell()
    func didPlaygroungFinished()
}


class STVPlaygroung : UIView {
    var playgroungDelegate :STVPlaygroungDelegate? = nil

    @IBOutlet weak var containerCells :UIView!

    var _currenntIndexItem :Int = 0
    var _maxIndexItem :Int = 0
    var _levelComplexity :Int = 0


    public func fillContent() {
        for view in containerCells.subviews {
            view.removeFromSuperview()
        }

        let content :Array<String> = STVPlaygroung.contentByCell()
        let segments: STSizeSegments = self.selectSegmentsByCount(content.count)
        let minimal :CGFloat = self.minimalProportionsCell()

        _currenntIndexItem = 1
        _maxIndexItem = content.count

        let rectPlayground :CGRect = self.rectPlayground(minimal: minimal, segments: segments)
        let size :CGSize = CGSize(width: minimal - 2, height: minimal - 2)
        self.settingsContainerCells(rectPlayground)

        let mutArrTemporary :NSMutableArray = NSMutableArray(array: content)
        mutArrTemporary.addObjects(from: Array(repeatElement("", count: (segments.rawValue * segments.rawValue - content.count))))

        for i in 0..<segments.rawValue {
            for j in 0..<segments.rawValue {
                let _button :UIButton = UIButton(frame: CGRect(origin: CGPoint(x: CGFloat(i) * minimal + 1, y: CGFloat(j) * minimal + 1), size: size))
                self.settingCell(button: _button, temporary: mutArrTemporary, pattern: content)
                containerCells.addSubview(_button)
            }
        }
    }


    private func settingsContainerCells(_ rect :CGRect) {
        containerCells.frame = rect
        containerCells.backgroundColor = STSettings.colorPlaygroundBack()
    }


    private func minimalProportionsCell() -> CGFloat {
        let height :CGFloat = self.bounds.size.height / CGFloat(STSizeSegments.STSegmengs7x7.rawValue)
        let width :CGFloat = self.bounds.size.width / CGFloat(STSizeSegments.STSegmengs7x7.rawValue)
        return CGFloat(min(height, width))
    }


    private func settingCell(button :UIButton, temporary :NSMutableArray, pattern :Array<String>) {
        let random :Int = Int(arc4random_uniform(UInt32(temporary.count)))
        button.setTitleColor(STSettings.colorPlaygroundCellTitle(), for: UIControlState.normal)
        button.setTitle(temporary[random] as? String , for: UIControlState.normal)
        button.backgroundColor = STSettings.colorPlaygroundCellDefault()

        if (pattern.contains((temporary[random] as? String)!)) {
            button.tag = pattern.index(of: temporary[random] as! String)! + _currenntIndexItem
            button.addTarget(self, action: #selector(ibaCell), for: UIControlEvents.touchUpInside)
        }
        temporary.removeObject(at: random)
    }


    @objc private func ibaCell(button :UIButton) {
        if (button.tag == _currenntIndexItem || _currenntIndexItem >= _maxIndexItem) {
            self.selectNextCell()
        } else {
            selectedWrongCellWithNum(button.tag)
        }
    }


    public func selectPreviewCell() {
        if (_currenntIndexItem > 1) {
            _currenntIndexItem = _currenntIndexItem - 1
            let button :UIButton = containerCells.viewWithTag(_currenntIndexItem)! as! UIButton
            button.backgroundColor = STSettings.colorPlaygroundCellDefault()
        }
    }


    public func selectNextCell() {
        if (_currenntIndexItem <= _maxIndexItem) {
            let button :UIButton = containerCells.viewWithTag(_currenntIndexItem)! as! UIButton
            button.backgroundColor = STSettings.colorPlaygroundCellRule()
            _currenntIndexItem = _currenntIndexItem + 1
            playgroungDelegate?.didPlaygroungRuleCell()
        }

        if (_currenntIndexItem > _maxIndexItem) {
            playgroungDelegate?.didPlaygroungFinished()
        }
    }


    public func selectedWrongCellWithNum(_ num :Int) {
        let button :UIButton = containerCells.viewWithTag(num)! as! UIButton
        button.backgroundColor = STSettings.colorPlaygroundCellWrong()
        playgroungDelegate?.didPlaygroungWrongCell()
    }

}
