//
//  WWMenuViewController.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - 選單畫面的ViewController
open class WWMenuViewController: WWItemViewController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - 公開函式
public extension WWMenuViewController {
    
    /// 切換頁面
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    /// - Returns: Bool
    func changeItemViewController(_ viewController: UIViewController, duration: TimeInterval = Constant.delayTime, curve: UIView.AnimationCurve = .linear) -> Bool {
        
        guard let sideMenuViewController = parentViewController() as WWSideMenuViewController? else { return false }
        
        sideMenuViewController.changeItemViewController(viewController) {
            $0.dismiss(duration: duration, curve: curve)
        }
        
        return true
    }
}

