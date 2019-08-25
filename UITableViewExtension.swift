//
//  UITableViewExtension.swift
//  YouBank
//
//  Created by  on 2019/7/10.
//  Copyright © 2019 yunie. All rights reserved.
//

import UIKit

var pageKey = 101
var labelKey = 102
extension UITableView{
    public var page :Int{
        set {
            objc_setAssociatedObject(self, &pageKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            if let rs = objc_getAssociatedObject(self, &pageKey) as? Int {
                return rs
            }
            return 1
        }
    }
    public var noDataLabel: UILabel{
        set {
            objc_setAssociatedObject(self, &labelKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            var label = objc_getAssociatedObject(self, &labelKey) as? UILabel
            if label == nil{
                label = UILabel()
                label?.textColor = UIColor.jhHexString("999999")
                label?.font = UIFont.systemFont(ofSize: 15)
                label?.isHidden = true
                label?.textAlignment = .center
                insertSubview(label!, at: 0)
                label?.snp.makeConstraints({ (make) in
                    make.center.equalTo(self.snp.center)
                    make.width.equalTo(self.width)
                    make.height.equalTo(15)
                })
                self.noDataLabel = label!
                self.layoutIfNeeded()
            }
            return label!
        }
    }
    
    public func pageToFirst(){
        self.page = 1
    }
    
    public func setupPage<T>( arr: inout Array<T>){
        if self.page == 1{
            arr.removeAll()
        }
        self.page += 1
    }
    
    func showNoDataLabel(arr: Array<Any>){
        self.noDataLabel.isHidden = !(arr.count == 0 && (self.noDataLabel.text?.count ?? 0) > 0)
    }
    
    public func setupRefreshHeader(callBack: @escaping ()->()){
        self.mj_header = MJRefreshNormalHeader{
            callBack()
        }
    }
    
    public func setupRefreshFooter(callBack: @escaping ()->()){
        self.mj_footer = MJRefreshBackNormalFooter{
            callBack()
        }
    }
    
    public func beginRefresh(){
        self.mj_footer.resetNoMoreData()
        self.mj_header.beginRefreshing()
    }
    
    public func endRefresh(isNoMoreData: Bool = false){
        if isNoMoreData {
            self.mj_header.endRefreshing()
            self.mj_footer.endRefreshing()
            self.mj_footer.endRefreshingWithNoMoreData()
        } else {
            self.mj_header.endRefreshing()
            if (self.mj_footer != nil && self.mj_footer.isRefreshing){
                self.mj_footer.endRefreshing()
            }
        }
    }
}
