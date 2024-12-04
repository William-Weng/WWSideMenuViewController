//
//  Constant+WWSideMenuViewController.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import Foundation

public class Constant {
    
    public static let delayTime: TimeInterval = 0.25                    // 動畫的daley時間
}

// MARK: - typealias
extension Constant {
    
    typealias MenuPosition = (display: CGPoint, dismiss: CGPoint)       // 側邊選單的位置 (顯示 / 隱藏)
    typealias MenuMovePosition = (from: CGPoint, to: CGPoint)           // 側邊選單的移動位置 (從 / 到)
}

// MARK: - enum
extension Constant {
    
    // MARK: - 選單的狀態
    public enum MenuState {
        case display        // 已顯示
        case animation      // 動畫執行中
        case dismiss        // 已隱藏
    }
    
    // MARK: - 選單Segue
    public enum MenuSegue {
        
        case item
        case menu
        
        /// Segues的Id
        /// - Returns: String
        func identifier() -> String {
            switch self {
            case .item: return "WWSideMenuViewController.Item"
            case .menu: return "WWSideMenuViewController.Menu"
            }
        }
    }
    
    // MARK: - 選單彈出方向
    public enum MenuPopupDirection {
        case up
        case down
        case left
        case right
    }
}

