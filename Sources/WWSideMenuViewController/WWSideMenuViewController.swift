//
//  WWSideMenuViewController.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - 側邊選單主體
open class WWSideMenuViewController: UIViewController {
    
    public class Constant {
        public static let delayTime: TimeInterval = 0.25    // 動畫的daley時間
    }
    
    open override var prefersStatusBarHidden: Bool { return isStatusBarHidden }
    
    weak var delegate: WWSideMenuViewControllerDelegate?
    
    var displayPosition: Constant.MenuDisplayPosition = .front
    
    var isStatusBarHidden = false
    var itemContainerView: UIView = UIView()
    var menuContainerView: UIView = UIView()
    
    var firstItemViewController: UIViewController?
    var previousItemViewController: UIViewController?
    var menuViewController: UIViewController?
    
    private var menuPosition: Constant.MenuPosition = (.zero, .zero)
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performSegueAction()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.sideMenu(self, state: .dismiss)
    }
        
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        recordViewControllers(for: segue)
    }
    
    deinit {
        delegate = nil
    }
}

// MARK: - 公開函式
public extension WWSideMenuViewController {
    
    /// 初始化設定
    /// - Parameters:
    ///   - displayPosition: 選單顯示的位置 (正面 / 反面)
    ///   - delegate: WWSideMenuViewControllerDelegate?
    func initSetting(with displayPosition: Constant.MenuDisplayPosition = .front, delegate: WWSideMenuViewControllerDelegate? = nil) {
        self.delegate = delegate
        itemContainerView._autolayout(on: view)
        menuContainerViewSetting(on: view, displayPosition: displayPosition)
    }
}

// MARK: - 公用函式
extension WWSideMenuViewController {
    
    /// 顯示側邊選單
    /// - Parameters:
    ///   - direction: 選單彈出的方向
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    func display(with direction: Constant.MenuPopupDirection, duration: TimeInterval = Constant.delayTime, curve: UIView.AnimationCurve = .easeInOut) {
        menuAnimation(with: direction, displayPosition: displayPosition, duration: duration, curve: curve, state: .display)
    }
    
    /// 隱藏側邊選單
    /// - Parameters:
    ///   - direction: 選單彈出的方向
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    func dismiss(with direction: Constant.MenuPopupDirection, duration: TimeInterval = Constant.delayTime, curve: UIView.AnimationCurve = .easeInOut) {
        menuAnimation(with: direction, displayPosition: displayPosition, duration: duration, curve: curve, state: .dismiss)
    }
    
    /// 回到一開始的頁面 (第一頁)
    /// - Parameter completion: 完成後的動作
    func backFirstItemViewController(completion: ((WWSideMenuViewController) -> Void)?) {
        
        guard let firstItemViewController = firstItemViewController else { return }
        changeItemViewController(firstItemViewController, completion: completion)
    }
    
    /// 切換Item頁面
    /// - Parameters:
    ///   - itemViewController: UIViewController
    ///   - completion: 完成後的動作
    func changeItemViewController(_ itemViewController: UIViewController, completion: ((WWSideMenuViewController) -> Void)?) {
        
        _changeContainerView(at: itemContainerView, from: previousItemViewController, to: itemViewController)
        delegate?.sideMenu(self, from: previousItemViewController, to: itemViewController)
        previousItemViewController = itemViewController
        
        completion?(self)
    }
    
    /// 切換Menu頁面
    /// - Parameters:
    ///   - itemViewController: UIViewController
    ///   - completion: 完成後的動作
    func changeMenuViewController(_ menuViewController: UIViewController, completion: ((WWSideMenuViewController) -> Void)?) {
        
        _changeContainerView(at: menuContainerView, from: nil, to: menuViewController)
        delegate?.sideMenu(self, from: nil, to: menuViewController)
        
        completion?(self)
    }
}

// MARK: - 小工具
private extension WWSideMenuViewController {
        
    /// 選單View的設定
    /// - Parameters:
    ///   - view: UIView
    ///   - displayPosition: Constant.MenuDisplayPosition
    func menuContainerViewSetting(on view: UIView, displayPosition: Constant.MenuDisplayPosition) {
        
        self.displayPosition = displayPosition
        
        menuContainerView.removeFromSuperview()
        view.addSubview(menuContainerView)
        
        switch displayPosition {
        case .front:
            
            menuContainerView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                menuContainerView.topAnchor.constraint(equalTo: view.topAnchor),
                menuContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                menuContainerView.trailingAnchor.constraint(equalTo: view.leadingAnchor),
                menuContainerView.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
            
        case .back(_):
            
            menuContainerView.translatesAutoresizingMaskIntoConstraints = false
            menuContainerView._autolayout(on: view)            
            view.bringSubviewToFront(itemContainerView)
        }
    }
    
    /// 執行Segue
    func performSegueAction() {
        performSegue(withIdentifier: WWItemViewControllerSegue.identifier, sender: nil)
        performSegue(withIdentifier: WWMenuViewControllerSegue.identifier, sender: nil)
    }
    
    /// 選單動畫處理
    /// - Parameters:
    ///   - direction: 選單彈出的方向
    ///   - displayPosition: 選單的顯示位置
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    ///   - state: 選單狀態
    func menuAnimation(with direction: Constant.MenuPopupDirection, displayPosition: Constant.MenuDisplayPosition, duration: TimeInterval, curve: UIView.AnimationCurve, state: Constant.MenuState) {
        
        let position: Constant.MenuMovePosition
        menuPosition = menuPosition(with: direction, displayPosition: displayPosition)
        
        switch state {
        case .display: position = (from: menuPosition.dismiss, to: menuPosition.display); statusBarHiddenSetting(true)
        case .dismiss: position = (from: menuPosition.display, to: menuPosition.dismiss)
        case .animation: position = (from: .zero, to: .zero)
        }
        
        menuPositionSetting(position.from, displayPosition: displayPosition)
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: curve) { [unowned self] in
            delegate?.sideMenu(self, state: .animation)
            menuPositionSetting(position.to, displayPosition: displayPosition)
        }
        
        animator.addCompletion { [unowned self] _ in
            if (state == .dismiss) { statusBarHiddenSetting(false) }
            delegate?.sideMenu(self, state: state)
        }
        
        animator.startAnimation()
    }
    
    /// 根據彈出方向來決定相對的位置
    /// - Parameters:
    ///   - direction: Constant.MenuPopupDirection
    ///   - displayPosition: Constant.MenuDisplayPosition
    /// - Returns: Constant.MenuPosition
    func menuPosition(with direction: Constant.MenuPopupDirection, displayPosition: Constant.MenuDisplayPosition) -> Constant.MenuPosition {
                
        switch displayPosition {
        case .front: return frontMenuPosition(with: direction, frame: view.frame)
        case .back(let distance): return backMenuPosition(with: direction, distance: distance)
        }
    }
    
    /// 正面 / 一般型的選單位置
    /// - Parameter direction: Constant.MenuPopupDirection
    /// - Returns: Constant.MenuPosition
    func frontMenuPosition(with direction: Constant.MenuPopupDirection, frame: CGRect) -> Constant.MenuPosition {
        
        let position: Constant.MenuPosition
        
        switch direction {
        case .up: position = (display: .zero, dismiss: .init(x: 0, y: -frame.height))
        case .down: position = (display: .zero, dismiss: .init(x: 0, y: frame.height))
        case .left: position = (display: .zero, dismiss: .init(x: frame.width, y: 0))
        case .right: position = (display: .zero, dismiss: .init(x: -frame.width, y: 0))
        }
        
        return position
    }
    
    /// 底面 / 用推的ContainerView的位置
    /// - Returns: Constant.MenuPosition
    /// - Parameters:
    ///   - direction: Constant.MenuPopupDirection
    ///   - distance: CGFloat
    func backMenuPosition(with direction: Constant.MenuPopupDirection, distance: CGFloat) -> Constant.MenuPosition {
        
        let position: Constant.MenuPosition
        
        switch direction {
        case .up: position = (display: .init(x: 0, y: distance), dismiss: .zero)
        case .down: position = (display: .init(x: 0, y: -distance), dismiss: .zero)
        case .left: position = (display: .init(x: -distance, y: 0), dismiss: .zero)
        case .right: position = (display: .init(x: distance, y: 0), dismiss: .zero)
        }
        
        return position
    }
    
    /// 設定側邊選單 / ContainetView的位置
    /// - Parameters:
    ///   - position: CGPoint
    ///   - displayPosition: Constant.MenuDisplayPosition
    func menuPositionSetting(_ position: CGPoint, displayPosition: Constant.MenuDisplayPosition) {
        
        switch displayPosition {
        case .front: menuContainerView.frame.origin = position
        case .back(_): itemContainerView.frame.origin = position
        }
    }
    
    /// 記錄畫面跟選單的ViewController
    func recordViewControllers(for segue: UIStoryboardSegue) {
        if segue.identifier == WWItemViewControllerSegue.identifier { firstItemViewController = segue.destination; return }
        if segue.identifier == WWMenuViewControllerSegue.identifier { menuViewController = segue.destination as? WWMenuViewController; return }
    }
    
    /// 設定StatusBar的顯示狀態 (沒瀏海的會有問題)
    /// - Parameter isStatusBarHidden: Bool
    func statusBarHiddenSetting(_ isStatusBarHidden: Bool) {
        
        if (view.safeAreaInsets.top > 20) {
            self.isStatusBarHidden = isStatusBarHidden
            setNeedsStatusBarAppearanceUpdate()
        }
    }
}
