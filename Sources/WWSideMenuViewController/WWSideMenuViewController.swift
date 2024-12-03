//
//  WWSideMenuViewController.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - 側邊選單主體
open class WWSideMenuViewController: UIViewController {
        
    public private(set) var itemContainerView: UIView = UIView()
    public private(set) var menuContainerView: UIView = UIView()

    public weak var delegate: WWSideMenuViewControllerDelegate?
    
    var previousItemViewController: UIViewController?
    var menuViewController: UIViewController?
    
    private var menuPosition: Constant.MenuPosition = (.zero, .zero)
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performSegueAction()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.sideMenuState(self, state: .dismiss)
    }
        
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        initViewControllers(for: segue)
    }

    deinit {
        delegate = nil
    }
}

// MARK: - 公用函式
extension WWSideMenuViewController {
    
    /// 顯示側邊選單
    /// - Parameters:
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    func display(duration: TimeInterval = Constant.delayTime, curve: UIView.AnimationCurve = .easeInOut) {
        menuAnimation(duration: duration, curve: curve, state: .display)
    }
    
    /// 隱藏側邊選單
    /// - Parameters:
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    func dismiss(duration: TimeInterval = Constant.delayTime, curve: UIView.AnimationCurve = .easeInOut) {
        menuAnimation(duration: duration, curve: curve, state: .dismiss)
    }
    
    /// 切換頁面
    /// - Parameters:
    ///   - itemViewController: UIViewController
    ///   - completion: 完成後的動作
    func changeItemViewController(_ itemViewController: UIViewController, completion: ((WWSideMenuViewController) -> Void)?) {
        
        _changeContainerView(at: itemContainerView, from: previousItemViewController, to: itemViewController)
        previousItemViewController = itemViewController
        
        completion?(self)
    }
}

// MARK: - 小工具
private extension WWSideMenuViewController {
    
    /// 初始化設定
    func initSetting() {
        itemContainerView._autolayout(on: view)
        menuContainerViewSetting(on: view)
    }
    
    /// 選單View的設定
    /// - Parameter view: UIView
    func menuContainerViewSetting(on view: UIView) {
        
        menuContainerView.removeFromSuperview()
        view.addSubview(menuContainerView)
        
        menuContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            menuContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuContainerView.trailingAnchor.constraint(equalTo: view.leadingAnchor),
            menuContainerView.widthAnchor.constraint(equalTo: itemContainerView.widthAnchor)
        ])
    }
    
    /// 執行Segue
    func performSegueAction() {
        performSegue(withIdentifier: WWItemViewControllerSegue.identifier, sender: nil)
        performSegue(withIdentifier: WWMenuViewControllerSegue.identifier, sender: nil)
    }
    
    /// 選單動畫處理
    /// - Parameters:
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    ///   - state: 選單狀態
    func menuAnimation(duration: TimeInterval, curve: UIView.AnimationCurve, state: Constant.MenuState) {
        
        let position: Constant.MenuMovePosition
        menuPosition = (display: .zero, dismiss: .init(x: -view.frame.width, y: 0))
        
        switch state {
        case .display: position = (from: menuPosition.dismiss, to: menuPosition.display)
        case .dismiss: position = (from: menuPosition.display, to: menuPosition.dismiss)
        case .animation: position = (from: .zero, to: .zero)
        }
        
        menuPositionSetting(position.from)
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: curve) { [unowned self] in
            delegate?.sideMenuState(self, state: .animation)
            menuPositionSetting(position.to)
        }
        
        animator.addCompletion { [unowned self] _ in
            delegate?.sideMenuState(self, state: state)
        }
        
        animator.startAnimation()
    }
    
    /// 設定側邊選單的位置
    func menuPositionSetting(_ position: CGPoint) {
        menuContainerView.frame.origin = position
    }
    
    /// 記錄畫面跟選單的ViewController
    func initViewControllers(for segue: UIStoryboardSegue) {
        
        if segue.identifier == WWItemViewControllerSegue.identifier { previousItemViewController = segue.destination; return }
        if segue.identifier == WWMenuViewControllerSegue.identifier { menuViewController = segue.destination as? WWMenuViewController; return }
    }
}
