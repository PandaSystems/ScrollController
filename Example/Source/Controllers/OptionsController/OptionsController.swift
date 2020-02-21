//
//  OptionsController.swift
//  SlideController_Example
//
//  Created by Evgeny Dedovets on 9/6/17.
//  Copyright © 2017 Touchlane LLC. All rights reserved.
//

import UIKit

protocol OptionsControllerProtocol: AnyObject {
    var openHorizontalDemoAction: (() -> Void)? { get set }
    var openVerticalDemoAction: (() -> Void)? { get set }
    var openCarouselDemoAction: (() -> Void)? { get set }
}

class OptionsController {
    private let internalView = OptionsView()
}

private typealias OptionsControllerProtocolImplementation = OptionsController
extension OptionsControllerProtocolImplementation: OptionsControllerProtocol {
    var openHorizontalDemoAction: (() -> Void)? {
        get {
            internalView.horizontalDemoButton.didTouchUpInside
        }
        set {
            internalView.horizontalDemoButton.didTouchUpInside = newValue
        }
    }

    var openVerticalDemoAction: (() -> Void)? {
        get {
            internalView.verticalDemoButton.didTouchUpInside
        }
        set {
            internalView.verticalDemoButton.didTouchUpInside = newValue
        }
    }

    var openCarouselDemoAction: (() -> Void)? {
        get {
            internalView.carouselDemoButton.didTouchUpInside
        }
        set {
            internalView.carouselDemoButton.didTouchUpInside = newValue
        }
    }
}

private typealias ViewAccessibleImplementation = OptionsController
extension ViewAccessibleImplementation: ViewAccessible {
    var view: UIView {
        internalView
    }
}

private typealias StatusBarAccessibleImplementation = OptionsController
extension StatusBarAccessibleImplementation: StatusBarAccessible {
    var statusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

private typealias TitleAccessibleImplementation = OptionsController
extension TitleAccessibleImplementation: TitleAccessible {
    var title: String {
        "SlideController"
    }
}

private typealias TitleColorableImplementation = OptionsController
extension TitleColorableImplementation: TitleColorable {
    var titleColor: UIColor {
        .white
    }
}
