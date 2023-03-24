//
//  ListViewModel.swift
//  foodieList
//
//  Created by Jube on 2023/3/22.
//

import Foundation
import UIKit

protocol ListViewModelDelegate: AnyObject {
    func wishListChange()
    
    func checkedListChange()
}


class ListViewModel {
    
    weak var delegate: ListViewModelDelegate?
    
    var unCheckedLists = [Info]() {
        didSet{
            delegate?.wishListChange()
            Info.saveUnCheckedInfo(infos: unCheckedLists)
        }
    }
    
    var checkedLists = [Info]() {
        didSet{
            delegate?.checkedListChange()
            Info.saveCheckedInfo(Infos: checkedLists)
            print("save")
        }
    }
    
}

extension ListViewModel {
    
    func wishBgStyle(height: CGFloat, cornerRadius: CGFloat, view: UIView){
        let wishBgLayer = CAShapeLayer()
        let wishBgPath = UIBezierPath()
        wishBgPath.move(to: CGPoint(x: 0.0, y: view.bounds.height))
        wishBgPath.addLine(to: CGPoint(x: 0.0, y: view.bounds.height-height+cornerRadius))
        wishBgPath.addQuadCurve(to: CGPoint(x: cornerRadius, y: view.bounds.height-height), controlPoint: CGPoint(x: 0.0, y: view.bounds.height-height))
        wishBgPath.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height-height))
        wishBgPath.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height))
        wishBgLayer.path = wishBgPath.cgPath
        wishBgLayer.fillColor = CGColor(gray: 1, alpha: 1)
        wishBgLayer.shadowColor = CGColor(red: 20/255, green: 62/255, blue: 40/255, alpha: 1)
        wishBgLayer.shadowOpacity = 0.25
        wishBgLayer.shadowRadius = 36
        wishBgLayer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        view.layer.insertSublayer(wishBgLayer, at: 0)
    }
    
    func loadAllLists() {
        if let unCheckedLists = Info.loadUnCheckedInfo(){
            self.unCheckedLists = unCheckedLists
        }
        if let checkedLists = Info.loadCheckedInfo() {
            self.checkedLists = checkedLists
        }
    }
    
    func checkOnWishListAt(index: Int) {
        unCheckedLists[index].checked = true
        let removedList = unCheckedLists.remove(at: index)
        checkedLists.insert(removedList, at: 0)
    }
    
    func unCheckOnCeckListAt(index: Int) {
        checkedLists[index].checked = false
        let removeList = checkedLists.remove(at: index)
        unCheckedLists.insert(removeList, at: 0)
    }
    
    func nameOnUnCheckList(index:Int) -> String {
        unCheckedLists[index].name
    }
    
    func btnImageOnUnCheckList(index:Int) -> UIImage {
        UIImage(named: checkedLists[index].btnImageName)!
    }
    
    func nameOnCheckList(index:Int) -> String {
        unCheckedLists[index].name
    }
    
    func btnImageOnCheckList(index:Int) -> UIImage {
        UIImage(named: checkedLists[index].btnImageName)!
    }
}

extension ListViewModel {
    func numberOfUnCheckedList() -> Int {
        unCheckedLists.count
    }
    
    func numberOfCheckedList() -> Int {
        checkedLists.count
    }
}
