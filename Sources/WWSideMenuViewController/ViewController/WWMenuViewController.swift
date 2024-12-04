//
//  WWMenuViewController.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - 選單畫面的ViewController
open class WWMenuViewController: WWItemViewController {}

// MARK: - 公開函式
public extension WWMenuViewController {
    
    /// 回到一開始的頁面 (第一頁)
    /// - Parameters:
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    /// - Returns: Bool
    func backFirstItemViewController(duration: TimeInterval = Constant.delayTime, curve: UIView.AnimationCurve = .linear) -> Bool {
        
        guard let sideMenuViewController = parentViewController() as WWSideMenuViewController? else { return false }
        
        sideMenuViewController.backFirstItemViewController() {
            $0.dismiss(duration: duration, curve: curve)
        }
        
        return true
    }
    
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

