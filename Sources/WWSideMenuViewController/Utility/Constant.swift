//
//  Constant.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - typealias
extension WWSideMenuViewController {
    
    public typealias SegueIdentifier = (item: String, menu: String)                                                             // 側邊選單的Segue名稱
    public typealias ViewController = (item: UIViewController, menu: UIViewController)                                          // 側邊選單的UIViewController
    
    typealias MenuPosition = (display: CGPoint, dismiss: CGPoint)                                                               // 側邊選單的位置 (顯示 / 隱藏)
    typealias MenuMovePosition = (from: CGPoint, to: CGPoint)                                                                   // 側邊選單的移動位置 (從 / 到)
    typealias MenuAnimationInformation = (direction: MenuPopupDirection, duration: TimeInterval, curve: UIView.AnimationCurve)  // 側邊選單動畫效果的相關資訊
    typealias BaseViewAlpha = (from: CGFloat, to: CGFloat)                                                                      // 底部View透明度
}

// MARK: - enum
public extension WWSideMenuViewController {
    
    // MARK: - 選單的狀態
    enum MenuState {
        case display        // 已顯示
        case animation      // 動畫執行中
        case dismiss        // 已隱藏
    }
    
    // MARK: - 選單彈出的方向
    enum MenuPopupDirection {
        case up     // 在上方
        case down   // 在下方
        case left   // 在左方
        case right  // 在右方
    }
    
    // MARK: - 選單出現的位置
    enum MenuDisplayPosition {
        case front                                                                  // 在ContainerView的上方 (一般型)
        case back(_ distance: CGFloat)                                              // 在ContainerView的下方 (用推的)
        case scale(_ distance: CGFloat, _ scale: CGFloat, _ cornerRadius: CGFloat)  // 在ContainerView的下方 (縮放)
    }
}

