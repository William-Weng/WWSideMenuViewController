//
//  Extension+WWSideMenuViewController.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - UIView
extension UIView {
    
    /// [設定LayoutConstraint => 不能加frame](https://zonble.gitbooks.io/kkbox-ios-dev/content/autolayout/intrinsic_content_size.html)
    /// - Parameter view: [要設定的View](https://www.appcoda.com.tw/auto-layout-programmatically/)
    func _autolayout(on view: UIView) {

        removeFromSuperview()
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - UIViewController
extension UIViewController {
    
    /// [改變ContainerView](https://disp.cc/b/11-9XMd)
    /// - Parameters:
    ///   - containerView: UIView
    ///   - oldViewController: 舊的ViewController
    ///   - newViewController: 新的ViewController
    func _changeContainerView(at containerView: UIView, from oldViewController: UIViewController? = nil, to newViewController: UIViewController) {
        
        oldViewController?.willMove(toParent: self)
        oldViewController?.view.removeFromSuperview()
        oldViewController?.removeFromParent()
                
        addChild(newViewController)
        newViewController.view._autolayout(on: containerView)
        newViewController.didMove(toParent: self)
    }
    
    /// 找出上一層的特定類型的ViewController
    /// - Parameter viewController: UIViewController?
    /// - Returns: WWSideMenuController?
    func parentViewController<T: UIViewController>() -> T? {
        
        guard let parent = parent else { return nil }
        
        if let sideMenuController = parent as? T { return sideMenuController }
        return parent.parentViewController()
    }
}

