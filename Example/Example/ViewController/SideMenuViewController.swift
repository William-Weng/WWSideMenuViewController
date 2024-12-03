//
//  SideMenuViewController.swift
//  Example
//
//  Created by William.Weng on 2024/12/3.
//

import UIKit
import WWPrint
import WWSideMenuViewController

// MARK: - ViewController
final class SideMenuViewController: WWSideMenuViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension SideMenuViewController: WWSideMenuViewControllerDelegate {
    
    func sideMenuState(_ sideMenuController: WWSideMenuViewController, state: Constant.MenuState) {
        wwPrint(state)
    }
}

