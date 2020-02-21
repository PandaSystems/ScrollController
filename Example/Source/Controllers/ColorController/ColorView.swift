//
//  ColorView.swift
//  SlideController_Example
//
//  Created by Evgeny Dedovets on 8/10/17.
//  Copyright © 2017 Touchlane LLC. All rights reserved.
//

import UIKit

class ColorView: UIView {
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = randomColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private typealias PrivateColorView = ColorView
private extension PrivateColorView {
    func randomColor() -> UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
