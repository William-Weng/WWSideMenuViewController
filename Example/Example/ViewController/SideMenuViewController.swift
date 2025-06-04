//
//  SideMenuViewController.swift
//  Example
//
//  Created by William.Weng on 2024/12/3.
//

import UIKit
import WWSideMenuViewController

// MARK: - ViewController
final class SideMenuViewController: WWSideMenuViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSettingWithSegue(delegate: self)
        // initSettingWithSegue(displayPosition: .back(256), delegate: self)
        // initSettingWithSegue(displayPosition: .scale(365, 0.8, 32.0), baseColor: .clear, delegate: self)
    }
}

// MARK: - WWSideMenuViewControllerDelegate
extension SideMenuViewController: WWSideMenuViewControllerDelegate {
    
    func sideMenu(_ sideMenuController: WWSideMenuViewController, state: MenuState) {
        print(state)
    }
    
    func sideMenu(_ sideMenuController: WWSideMenuViewController, from previousViewController: UIViewController?, to nextViewController: UIViewController) {
        print("from: \(String(describing: previousViewController)) to: \(nextViewController)")
    }
}

