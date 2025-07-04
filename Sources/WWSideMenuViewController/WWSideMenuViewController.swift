//
//  WWSideMenuViewController.swift
//  WWSideMenuViewController
//
//  Created by William.Weng on 2024/12/2.
//

import UIKit

// MARK: - 側邊選單主體
open class WWSideMenuViewController: UIViewController {
    
    open override var prefersStatusBarHidden: Bool { return isStatusBarHidden }
        
    weak var delegate: WWSideMenuViewControllerDelegate?
    
    var displayPosition: MenuDisplayPosition = .front
    
    var isStatusBarHidden = false
    var itemContainerView: UIView = UIView()
    var menuContainerView: UIView = UIView()
    
    var firstItemViewController: UIViewController?
    var previousItemViewController: UIViewController?
    var menuViewController: UIViewController?
    
    private var baseColor: UIColor = .clear
    private var menuPosition: MenuPosition = (.zero, .zero)
    private var baseView = UIView()
    private var displayMenuAnimationInformation = MenuAnimationInformation(.right, 0, .easeInOut)
    private var segueIdentifier: SegueIdentifier = (item: "WWSideMenuViewController.Item", menu: "WWSideMenuViewController.Menu")
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initBaseView()
        delegate?.sideMenu(self, state: .dismiss)
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        recordViewControllers(for: segue)
    }
    
    deinit {
        delegate = nil
    }
}

// MARK: - @objc
@objc extension WWSideMenuViewController {
    
    /// 點擊Item會退回選單
    /// - Parameter tap: UITapGestureRecognizer
    func handleVisualEffectView(_ tap: UITapGestureRecognizer) {
        dismiss(with: displayMenuAnimationInformation.direction, duration: displayMenuAnimationInformation.duration, curve: displayMenuAnimationInformation.curve)
    }
}

// MARK: - 公開函式
public extension WWSideMenuViewController {
    
    /// 初始化設定 (SegueIdentifier)
    /// - Parameters:
    ///   - segueIdentifier: Segue的Id名稱
    ///   - displayPosition: 選單顯示的位置 (正面 / 反面)
    ///   - baseColor: 底View的顏色
    ///   - delegate: WWSideMenuViewControllerDelegate?
    func initSettingWithSegue(_ segueIdentifier: SegueIdentifier = (item: "WWSideMenuViewController.Item", menu: "WWSideMenuViewController.Menu"), displayPosition: MenuDisplayPosition = .front, baseColor: UIColor = .black.withAlphaComponent(0.3), delegate: WWSideMenuViewControllerDelegate? = nil) {
        
        initSetting(with: displayPosition, baseColor: baseColor, delegate: delegate)
        
        self.segueIdentifier = segueIdentifier
        performSegueAction()
    }
    
    /// 初始化設定 (UIViewController)
    /// - Parameters:
    ///   - viewController: ViewController
    ///   - displayPosition: 選單顯示的位置 (正面 / 反面)
    ///   - baseColor: 底View的顏色
    ///   - delegate: WWSideMenuViewControllerDelegate?
    func initSettingWithViewController(_ viewController: ViewController, displayPosition: MenuDisplayPosition = .front, baseColor: UIColor = .black.withAlphaComponent(0.3), delegate: WWSideMenuViewControllerDelegate? = nil) {
        
        initSetting(with: displayPosition, baseColor: baseColor, delegate: delegate)
        firstItemViewController = viewController.item
        
        changeItemViewController(viewController.item, completion: nil)
        changeMenuViewController(viewController.menu, completion: nil)
    }
}

// MARK: - 公用函式
extension WWSideMenuViewController {
    
    /// 初始化基本設定
    /// - Parameters:
    ///   - displayPosition: 選單顯示的位置 (正面 / 反面)
    ///   - baseColor: 底View的顏色
    ///   - delegate: WWSideMenuViewControllerDelegate?
    func initSetting(with displayPosition: MenuDisplayPosition = .front, baseColor: UIColor, delegate: WWSideMenuViewControllerDelegate?) {
        
        self.delegate = delegate
        self.baseColor = baseColor
        
        itemContainerView._autolayout(on: view)
        
        switch displayPosition {
        case .front, .back(let _): break
        case .scale(_, _, let cornerRadius):
            itemContainerView.clipsToBounds = false
            itemContainerView.layer.cornerRadius = cornerRadius
        }
        
        menuContainerViewSetting(on: view, displayPosition: displayPosition)
    }
    
    /// 顯示側邊選單
    /// - Parameters:
    ///   - direction: 選單彈出的方向
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    func display(with direction: MenuPopupDirection, duration: TimeInterval, curve: UIView.AnimationCurve) {
        displayMenuAnimationInformation = (direction, duration, curve)
        menuAnimation(with: direction, displayPosition: displayPosition, duration: duration, curve: curve, state: .display)
    }
    
    /// 隱藏側邊選單
    /// - Parameters:
    ///   - direction: 選單彈出的方向
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    func dismiss(with direction: MenuPopupDirection, duration: TimeInterval, curve: UIView.AnimationCurve) {
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
    ///   - menuViewController: UIViewController
    ///   - completion: 完成後的動作
    func changeMenuViewController(_ menuViewController: UIViewController, completion: ((WWSideMenuViewController) -> Void)?) {
        
        _changeContainerView(at: menuContainerView, from: nil, to: menuViewController)
        delegate?.sideMenu(self, from: nil, to: menuViewController)
        
        completion?(self)
    }
}

// MARK: - 小工具
private extension WWSideMenuViewController {
    
    /// 初始化防被按的BaseView
    func initBaseView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleVisualEffectView))
        
        baseView.frame = itemContainerView.frame
        baseView.backgroundColor = baseColor
        baseView.addGestureRecognizer(tap)
    }
    
    /// 選單View的設定
    /// - Parameters:
    ///   - view: UIView
    ///   - displayPosition: MenuDisplayPosition
    func menuContainerViewSetting(on view: UIView, displayPosition: MenuDisplayPosition) {
        
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
            
        case .back(_), .scale(_):
            
            menuContainerView.translatesAutoresizingMaskIntoConstraints = false
            menuContainerView._autolayout(on: view)            
            view.bringSubviewToFront(itemContainerView)
        }
    }
    
    /// 執行Segue
    func performSegueAction() {
        performSegue(withIdentifier: segueIdentifier.item, sender: nil)
        performSegue(withIdentifier: segueIdentifier.menu, sender: nil)
    }
    
    /// 選單動畫處理
    /// - Parameters:
    ///   - direction: 選單彈出的方向
    ///   - displayPosition: 選單的顯示位置
    ///   - duration: 動畫時間
    ///   - curve: 動畫型式
    ///   - state: 選單狀態
    func menuAnimation(with direction: MenuPopupDirection, displayPosition: MenuDisplayPosition, duration: TimeInterval, curve: UIView.AnimationCurve, state: MenuState) {
        
        let alpha: BaseViewAlpha
        let position: MenuMovePosition
        let transform: CGAffineTransform
        
        menuPosition = menuPosition(with: direction, displayPosition: displayPosition)
        
        switch state {
        case .display:
            position = (from: menuPosition.dismiss, to: menuPosition.display)
            alpha = (from: 0.0 , to: 1.0)
            itemContainerView.addSubview(baseView)
            statusBarHiddenSetting(true)
        case .dismiss:
            position = (from: menuPosition.display, to: menuPosition.dismiss)
            alpha = (from: 1.0 , to: 0.0)
        case .animation:
            position = (from: .zero, to: .zero)
            alpha = (from: 0.0 , to: 0.0)
        }
        
        menuPositionSetting(position.from, displayPosition: displayPosition)
        baseView.alpha = alpha.from
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: curve) { [unowned self] in
            
            delegate?.sideMenu(self, state: .animation)
            baseView.alpha = alpha.to
            
            switch displayPosition {
            case .front, .back(_): menuPositionSetting(position.to, displayPosition: displayPosition)
            case .scale(let distance, let scale, _): itemContainerView.transform = itemTransform(with: direction, state: state, distance: distance, scale: scale)
            }
        }
        
        animator.addCompletion { [unowned self] _ in
            if (state == .dismiss) { baseView.removeFromSuperview(); statusBarHiddenSetting(false) }
            delegate?.sideMenu(self, state: state)
        }
        
        animator.startAnimation()
    }
        
    /// 根據彈出方向來決定相對的位置
    /// - Parameters:
    ///   - direction: MenuPopupDirection
    ///   - displayPosition: MenuDisplayPosition
    /// - Returns: MenuPosition
    func menuPosition(with direction: MenuPopupDirection, displayPosition: MenuDisplayPosition) -> MenuPosition {
        
        switch displayPosition {
        case .front: return frontMenuPosition(with: direction, frame: view.frame)
        case .back(let distance): return backMenuPosition(with: direction, distance: distance)
        case .scale(let distance, _, _): return backMenuPosition(with: direction, distance: distance)
        }
    }
    
    /// 正面 / 一般型的選單位置
    /// - Parameter direction: MenuPopupDirection
    /// - Returns: MenuPosition
    func frontMenuPosition(with direction: MenuPopupDirection, frame: CGRect) -> MenuPosition {
        
        let position: MenuPosition
        
        switch direction {
        case .up: position = (display: .zero, dismiss: .init(x: 0, y: -frame.height))
        case .down: position = (display: .zero, dismiss: .init(x: 0, y: frame.height))
        case .left: position = (display: .zero, dismiss: .init(x: frame.width, y: 0))
        case .right: position = (display: .zero, dismiss: .init(x: -frame.width, y: 0))
        }
        
        return position
    }
    
    /// 底面 / 用推的ContainerView的位置
    /// - Returns: MenuPosition
    /// - Parameters:
    ///   - direction: MenuPopupDirection
    ///   - distance: CGFloat
    func backMenuPosition(with direction: MenuPopupDirection, distance: CGFloat) -> MenuPosition {
        
        let position: MenuPosition
        
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
    ///   - displayPosition: MenuDisplayPosition
    func menuPositionSetting(_ position: CGPoint, displayPosition: MenuDisplayPosition) {
        
        switch displayPosition {
        case .front: menuContainerView.frame.origin = position
        case .back(_): itemContainerView.frame.origin = position
        case .scale(_, _, _): break
        }
    }
    
    /// 設定Item的縮放比例
    /// - Parameters:
    ///   - direction: 選單彈出的方向
    ///   - state: 選單狀態
    ///   - distance: 移動距離
    ///   - scale: 縮放比例
    /// - Returns: CGAffineTransform
    func itemTransform(with direction: MenuPopupDirection, state: MenuState, distance: CGFloat, scale: CGFloat) -> CGAffineTransform {
        
        var transform: CGAffineTransform = .identity
        
        if (state == .display) {
            
            switch direction {
            case .up: transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: 0, y: -distance)
            case .down: transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: 0, y: distance)
            case .left: transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: -distance, y: 0)
            case .right: transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: distance, y: 0)
            }
        }
        
        return transform
    }
    
    /// 記錄畫面跟選單的ViewController
    func recordViewControllers(for segue: UIStoryboardSegue) {
        if segue.identifier == segueIdentifier.item { firstItemViewController = segue.destination; return }
        if segue.identifier == segueIdentifier.menu { menuViewController = segue.destination as? WWMenuViewController; return }
    }
    
    /// 設定StatusBar的顯示狀態 + 圓角設定 (沒瀏海的會有問題)
    /// - Parameter isStatusBarHidden: Bool
    func statusBarHiddenSetting(_ isStatusBarHidden: Bool) {
        
        if (view.safeAreaInsets.top > 20) {
            self.isStatusBarHidden = isStatusBarHidden
            setNeedsStatusBarAppearanceUpdate()
        }
        
        itemContainerView.clipsToBounds = isStatusBarHidden
    }
}
