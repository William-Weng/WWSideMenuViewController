//
//  MenuViewController.swift
//  Example
//
//  Created by William.Weng on 2024/12/3.
//

import UIKit
import WWPrint
import WWSideMenuViewController

class MenuViewController: WWMenuViewController {
    
    lazy var pageViewController: UIViewController = {
        self.storyboard!.instantiateViewController(withIdentifier: "Page")
    }()
    
    lazy var tabViewController: UIViewController = {
        self.storyboard!.instantiateViewController(withIdentifier: "Tab")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dimissMenu(_ sender: UIButton) {
        _ = dismiss()
    }
    
    @IBAction func changePageViewController(_ sender: UIButton) {
        _ = changeItemViewController(pageViewController)
    }
    
    @IBAction func changeTabViewController(_ sender: UIButton) {
        _ = changeItemViewController(tabViewController)
    }
}
