//
//  Protocol+WWSideMenuViewController.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - WWSideMenuViewControllerDelegate
public protocol WWSideMenuViewControllerDelegate: AnyObject {
    
    /// 側邊選單的狀態
    /// - Parameters:
    ///   - sideMenuController: WWSideMenuViewController
    ///   - state: Constant.MenuState
    func sideMenuState(_ sideMenuController: WWSideMenuViewController, state: Constant.MenuState)
}
