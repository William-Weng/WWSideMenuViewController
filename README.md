# WWSideMenuViewController

[![Swift-5.6](https://img.shields.io/badge/Swift-5.6-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-14.0](https://img.shields.io/badge/iOS-14.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![](https://img.shields.io/github/v/tag/William-Weng/WWSideMenuViewController) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

## [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- [Customizable side menu of the screen.](https://github.com/kukushi/SideMenu)
- [可以自訂畫面的側邊選單。](https://github.com/William-Weng/Cocoapods)

![WWSideMenuViewController](./Example.webp)

## [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```bash
dependencies: [
    .package(url: "https://github.com/William-Weng/WWSideMenuViewController.git", .upToNextMajor(from: "1.0.0"))
]
```

## 相關設定
![WWSideMenuViewController](./Setting.png)
![WWSideMenuViewController](./Setting_Item.webp)
![WWSideMenuViewController](./Setting_Menu.webp)

## 可用函式
|函式|說明|
|-|-|
|display(duration:curve:)|顯示側邊選單|
|dismiss(duration:curve:)|隱藏側邊選單|
|changeItemViewController(_:duration:curve:)|切換頁面|

## WWSideMenuViewControllerDelegate
|函式|說明|
|-|-|
|sideMenuState(_:state:)|側邊選單的狀態|

## Example
```swift
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
```
```swift
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
```
```swift
import UIKit
import WWSideMenuViewController

class Page1ViewController: WWItemViewController {
    @IBAction func diplayMenu(_ sender: UIBarButtonItem) { _ = display() }
}

class Tab1ViewController: WWItemViewController {
    @IBAction func diplayMenu(_ sender: UIButton) { _ = display() }
}

class Tab2ViewController: WWItemViewController {
    @IBAction func diplayMenu(_ sender: UIButton) { _ = display() }
}
```

