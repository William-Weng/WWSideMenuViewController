//
//  ItemViewController.swift
//  Example
//
//  Created by William.Weng on 2024/12/3.
//

import UIKit
import WWSideMenuViewController

class Page1ViewController: WWItemViewController {
    @IBAction func diplayMenu(_ sender: UIBarButtonItem) { _ = displayMenu() }
}

class Tab1ViewController: WWItemViewController {
    @IBAction func diplayMenu(_ sender: UIButton) { _ = displayMenu() }
}

class Tab2ViewController: WWItemViewController {
    @IBAction func diplayMenu(_ sender: UIButton) { _ = displayMenu() }
}

