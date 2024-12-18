//
//  WWMenuViewControllerSegue.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - WWMenuViewControllerSegue
open class WWMenuViewControllerSegue: UIStoryboardSegue {
    
    override open func perform() {
        embedInMenuController()
    }
}

// MARK: - 小工具
private extension WWMenuViewControllerSegue {
    
    /// 嵌入MenuController到ContainerView中
    func embedInMenuController() {
        
        guard let sideMenuViewController = source as? WWSideMenuViewController,
              let menuController = destination as? WWMenuViewController
        else {
            return
        }
        
        sideMenuViewController.changeMenuViewController(menuController, completion: nil)
    }
}
