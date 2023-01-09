//
//  EditViewController.swift
//  foodieList
//
//  Created by Jube on 2023/1/6.
//

import UIKit

class EditViewController: UIViewController {
    
    var infoTableViewController : InfoTableViewController!

    @IBOutlet weak var tableviewContainer: UIView!
    @IBOutlet weak var nameEditLabel: UITextField!
    
    var newRestaurant: Info?
    var basicInfo: Info.BasicInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addPhoto(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let titles = ["從相簿選取", "從相機拍攝"]
        for title in titles {
            let action = UIAlertAction(title: title, style: .default) { action in
                if title == titles[0] {
                    imagePickerController.sourceType = .photoLibrary
                    imagePickerController.delegate = self
                } else {
                    
                }
            }
        }
        
        
    }
    
    @IBAction func done(_ sender: Any) {
        performSegue(withIdentifier: "backToMain", sender: nil)
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
        
        let name = nameEditLabel.text!
        newRestaurant = Info(name: name, basicInfo: basicInfo, imageName: "", comment: "", checked: false)
    }
    
    
}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}

