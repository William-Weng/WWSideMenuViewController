//
//  WWItemViewController.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - 顯示畫面的ViewController
open class WWItemViewController: UIViewController {}

// MARK: - 公開的函式
public extension WWItemViewController {
    
    /// 顯示側邊選單
    /// - Parameters:
    ///   - direction: 選單彈出的方向
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    /// - Returns: Bool
    func display(with direction: Constant.MenuPopupDirection = .right, duration: TimeInterval = 0.25, curve: UIView.AnimationCurve = .linear) -> Bool {
        
        guard let sideMenuController = parentViewController() as WWSideMenuViewController? else { return false }
        
        sideMenuController.display(with: direction, duration: duration, curve: curve)
        return true
    }
    
    /// 隱藏側邊選單
    /// - Parameters:
    ///   - direction: 選單彈出的方向
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    /// - Returns: Bool
    func dismiss(with direction: Constant.MenuPopupDirection = .right, duration: TimeInterval = 0.25, curve: UIView.AnimationCurve = .linear) -> Bool {
        
        guard let sideMenuController = parentViewController() as WWSideMenuViewController? else { return false }

        sideMenuController.dismiss(with: direction, duration: duration, curve: curve)
        return true
    }
}
