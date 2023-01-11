//
//  DetailViewController.swift
//  foodieList
//
//  Created by Jube on 2023/1/9.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    
    var restaurant: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        if let restaurant = restaurant {
            nameLabel.text = restaurant.name
            addressLabel.text = restaurant.address
            print(restaurant.imageName)
            if restaurant.imageName.isEmpty {
                restaurantImage.image = UIImage(named: "defaultImage")
            } else {
                let imageUrl = Info.documentDirectoryChecked.appendingPathComponent(restaurant.imageName).appendingPathExtension("jpg")
                restaurantImage.image = UIImage(contentsOfFile: imageUrl.path)
            }
            
            commentLabel.text = restaurant.comment
            phoneLabel.text = restaurant.phone
            captionLabel.text = restaurant.caption
            urlLabel.text = restaurant.googleLink?.description
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = restaurantImage.bounds
        gradientLayer.colors = [
            UIColor(red: 246/255, green: 246/255, blue: 242/255, alpha: 1).cgColor,
            UIColor(red: 246/255, green: 246/255, blue: 242/255, alpha: 0.4).cgColor,
            UIColor(red: 246/255, green: 246/255, blue: 242/255, alpha: 0).cgColor ]
        restaurantImage.layer.insertSublayer(gradientLayer, at: 0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationC = segue.destination as? EditViewController
        destinationC?.newRestaurant = restaurant
        print(destinationC?.newRestaurant, "toEdit")
    }

}
