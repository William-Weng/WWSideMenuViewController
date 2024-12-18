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
        initSetting(with: .front, delegate: self)
    }
}

// MARK: - WWSideMenuViewControllerDelegate
extension SideMenuViewController: WWSideMenuViewControllerDelegate {
    
    func sideMenu(_ sideMenuController: WWSideMenuViewController, state: MenuState) {
        wwPrint(state)
    }
    
    func sideMenu(_ sideMenuController: WWSideMenuViewController, from previousViewController: UIViewController?, to nextViewController: UIViewController) {
        wwPrint("from: \(String(describing: previousViewController)) to: \(nextViewController)")
    }
}

