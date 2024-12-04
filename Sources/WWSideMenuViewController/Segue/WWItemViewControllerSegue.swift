//
//  WWItemViewControllerSegue.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit
import WWPrint

// MARK: - WWItemViewControllerSegue
open class WWItemViewControllerSegue: UIStoryboardSegue {
    
    static let identifier = Constant.MenuSegue.item.identifier()
    
    override open func perform() {
        embedInItemController()
    }
}

// MARK: - 小工具
private extension WWItemViewControllerSegue {
    
    /// 嵌入ItemController到ContainerView中
    func embedInItemController() {
        guard let sideMenuViewController = source as? WWSideMenuViewController else { return }
        sideMenuViewController.changeItemViewController(destination, completion: nil)
    }
}
