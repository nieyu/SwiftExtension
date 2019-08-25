//
//  UIViewControllerExtension.swift
//  YouBank
//
//  Created by  on 2019/6/20.
//  Copyright © 2019 yunie. All rights reserved.
//

import UIKit

public protocol UIViewControllerCommonProtocol {
    func requestData()
}

extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}

extension UIViewController
{
    
    
    public func setNavigationBarTranslucent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage.init()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    public func setNavigationBar(color: UIColor = UIColor.clear) {
        if color != UIColor.clear {
            let image = UIImage.image(color: color, size: CGSize(width: SCREEN_WIDTH, height: NAVIGATION_BAR_HEIGHT + STATUS_BAR_HEIGHT))
            // 设置导航栏背景图片
            self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
            // 设置标题的颜色
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
            // 设置导航栏的透明度
            self.navigationController?.navigationBar.isTranslucent = false
            // 设置导航栏底部线条
            self.navigationController?.navigationBar.shadowImage = UIImage()
            // 设置状态栏的状态
            //        UIApplication.shared.statusBarStyle = .lightContent
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage.init()
            navigationController?.navigationBar.isTranslucent = true
        }
        
    }
    
    public func setNavigationBar(titleColor: UIColor) {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: titleColor,
            NSAttributedString.Key.font: Fonts.PingFang_SC_Regular_18.value
        ]
    }
    
    public func setLeftNavigationItem(isWhite: Bool = true) {
        var arrowName = ""
        if isWhite {
           arrowName = "left_arrow_white"
        } else {
           arrowName = "left_arrow"
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: arrowName),
                                                                style: UIBarButtonItem.Style.plain,
                                                                target: self,
                                                                action: #selector(popBack))
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc public func popBack() {
        self.navigationController?.popViewController(animated: true)
    }

    
    public func setCommonLightGrayBackground() {
        view.backgroundColor = Color.BackgroundGray.rawValue
    }
    
    struct RuntimeKey {
        static var hudKey = UnsafeRawPointer.init(bitPattern: "hudKey".hashValue)
        static var isloadingKey = UnsafeRawPointer.init(bitPattern: "isloadingKey".hashValue)
    }
    
    var isLoading:Bool{
        set{
            objc_setAssociatedObject(self,&RuntimeKey.isloadingKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            var res = (objc_getAssociatedObject(self, &RuntimeKey.isloadingKey) as? Bool)
            if res == nil{
                res = false
                self.isLoading = res!
            }
            return res!
        }
    }
    
    var progressHud : MBProgressHUD? {
        set(progressHud){
            objc_setAssociatedObject(self,&RuntimeKey.hudKey, progressHud, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            var progressHud = (objc_getAssociatedObject(self, &RuntimeKey.hudKey) as? MBProgressHUD)
            if progressHud == nil{
                progressHud = MBProgressHUD(view:self.view)
                progressHud?.frame = CGRect(x: 0, y: naviTopMargin, width: kScreenWidth, height: kScreenHeight - naviTopMargin)
                progressHud?.minSize = CGSize(width: 52, height: 52)
                progressHud?.mode = .indeterminate
                progressHud?.label.text = "加载中..."
                self.progressHud = progressHud
                self.view.addSubview(progressHud!)
            }
            return progressHud
        }
    }
    
    func jhShowHud() -> Void{
        self.isLoading = true
        self.progressHud?.show(animated: true)
        self.view.bringSubviewToFront(self.progressHud!)
    }
    
    func jhHideHud() -> Void {
        self.isLoading = false
        self.view.sendSubviewToBack(self.progressHud!)
        self.progressHud?.hide(animated: true)
    }
    
    func hideTabBar(_ hide: Bool) {
        //内嵌页面 不操作tabbar
        if !(self.parent! is UINavigationController) {
            return
        }
        
        //二级页面 不操作tabbar
        if !(self == self.navigationController?.viewControllers[0]) {
            return
        }
        
        self.tabBarController?.tabBar.isHidden = hide
        self.hidesBottomBarWhenPushed = hide
        _ = self.tabBarController?.view
        
        
        
    }
}

