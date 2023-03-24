//
//  DetailViewModel.swift
//  foodieList
//
//  Created by Jube on 2023/3/22.
//

import Foundation
import UIKit

class DetailViewModel {
    
    var restaurant: Info?
    
    var name: String? {
        return restaurant?.name
    }
    
    var address: String? {
        return restaurant?.address
    }
    
    var imageName: String? {
        return restaurant?.imageName
    }
    
    var comment: String? {
        return restaurant?.comment
    }
    
    var phone: String? {
        return restaurant?.phone
    }
    
    var caption: String? {
        return restaurant?.caption
    }
    
    var googleLink: URL? {
        return restaurant?.googleLink
    }
}

extension DetailViewModel {
    
    func makeGradientOn(image: UIImageView){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = image.bounds
        gradientLayer.colors = [
            UIColor(red: 246/255, green: 246/255, blue: 242/255, alpha: 1).cgColor,
            UIColor(red: 246/255, green: 246/255, blue: 242/255, alpha: 0.4).cgColor,
            UIColor(red: 246/255, green: 246/255, blue: 242/255, alpha: 0).cgColor ]
        image.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func image() -> UIImage {
        if imageName == nil {
            return UIImage(named: "defaultImage")!
        } else {
            let imageUrl = Info.documentDirectoryChecked.appendingPathComponent(imageName!).appendingPathExtension("jpg")
            return UIImage(contentsOfFile: imageUrl.path)!
        }
    }
}
