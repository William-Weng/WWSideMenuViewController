//
//  Protocol+WWSideMenuViewController.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - WWSideMenuViewControllerDelegate
public protocol WWSideMenuViewControllerDelegate: AnyObject {
    
    /// 側邊選單的動畫狀態
    /// - Parameters:
    ///   - sideMenuController: WWSideMenuViewController
    ///   - state: Constant.MenuState
    func sideMenu(_ sideMenuController: WWSideMenuViewController, state: WWSideMenuViewController.Constant.MenuState)
    
    /// 側邊選單的換頁順序
    /// - Parameters:
    ///   - sideMenuController: WWSideMenuViewController
    ///   - previousViewController: 上一個ViewController
    ///   - nextViewController: 下一個ViewController
    func sideMenu(_ sideMenuController: WWSideMenuViewController, from previousViewController: UIViewController?, to nextViewController: UIViewController)
}
