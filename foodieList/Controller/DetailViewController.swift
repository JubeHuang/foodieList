//
//  DetailViewController.swift
//  foodieList
//
//  Created by Jube on 2023/1/9.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func detailViewControllerDelegate(_ controller: DetailViewController, didSelect restaurant: Info, didSelect indexPath: IndexPath)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    
    weak var delegate: DetailViewControllerDelegate?
    var indexPath: IndexPath?
    var viewModel = DetailViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        viewModel.makeGradientOn(image: restaurantImage)
    }
    
    func updateUI() {
        
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
        commentLabel.text = viewModel.comment
        phoneLabel.text = viewModel.phone
        captionLabel.text = viewModel.caption
        urlLabel.text = viewModel.googleLink?.description
        restaurantImage.image = viewModel.image()
        
        guard let restaurant = viewModel.restaurant, let indexPath = indexPath else { return }
        delegate?.detailViewControllerDelegate(self, didSelect: restaurant, didSelect: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationC = segue.destination as? EditViewController
        destinationC?.delegate = self
        destinationC?.newRestaurant = viewModel.restaurant
    }

}

extension DetailViewController: EditViewControllerDelegate {
    func editViewControllerDelegate(_ controller: EditViewController, didEditRestaurant restaurant: Info) {
        viewModel.restaurant = restaurant
        print("畫面呈現\(viewModel.restaurant)", "delegate傳送\(restaurant)")
    }
}
