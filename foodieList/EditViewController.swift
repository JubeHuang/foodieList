//
//  EditViewController.swift
//  foodieList
//
//  Created by Jube on 2023/1/6.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var commentTextview: UITextView!
    @IBOutlet weak var captionTextfield: UITextField!
    @IBOutlet weak var urlTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var addressTextfield: UITextField!
    @IBOutlet weak var nameEditLabel: UITextField!
    
    var newRestaurant: Info?
    var hasPhoto = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let titles = ["從相簿選取", "從相機拍攝"]
        for title in titles {
            let action = UIAlertAction(title: title, style: .default) { action in
                let imagePickerController = UIImagePickerController()
                if title == titles[0] {
                    imagePickerController.sourceType = .photoLibrary
                } else {
                    imagePickerController.sourceType = .camera
                }
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true)
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func updateUI() {
        if let restaurant = newRestaurant {
            nameEditLabel.text = restaurant.name
            addressTextfield.text = restaurant.address
            captionTextfield.text = restaurant.caption
            phoneTextfield.text = restaurant.phone
            urlTextfield.text = restaurant.googleLink?.description
            commentTextview.text = restaurant.comment
            addPhotoBtn.setImage(UIImage(named: "add"), for: .normal)
            title = "編輯餐廳"
            
            if restaurant.imageName != "" {
                let imageUrl = Info.documentDirectoryChecked.appendingPathComponent(restaurant.imageName).appendingPathExtension("jpg")
                addPhotoBtn.configuration?.background.image = UIImage(contentsOfFile: imageUrl.path)
                addPhotoBtn.configuration?.background.imageContentMode = .scaleAspectFill
                addPhotoBtn.setImage(UIImage(), for: .normal)
                addPhotoBtn.setTitle("編輯照片", for: .normal)
                addPhotoBtn.configuration?.baseForegroundColor = UIColor(white: 1, alpha: 1)
            }
            
        } else {
            title = "新增餐廳"
            addPhotoBtn.setImage(UIImage(named: "add"), for: .normal)
        }
    }
    
    func editAlert(){
        let alertC = UIAlertController(title: "請填寫餐廳名稱", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertC.addAction(okAction)
        present(alertC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if nameEditLabel.text == "" {
            editAlert()
            return false
        } else {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let name = nameEditLabel.text!
        let address = addressTextfield.text ?? ""
        let phone = phoneTextfield.text ?? ""
        let url = urlTextfield.text ?? ""
        let comment = commentTextview.text ?? Info.unComment
        let caption = captionTextfield.text ?? ""
        var imageName: String?
        
        if hasPhoto {
            //有照片進到編輯
            if let restaurant = newRestaurant {
                imageName = restaurant.imageName
            }
            //剛新增照片 || 原本沒照片後來增加
            if imageName == "" || imageName == nil {
                imageName = UUID().uuidString
            }
            //將照片轉成data儲存
            let imageData = addPhotoBtn.configuration?.background.image?.jpegData(compressionQuality: 0.9)
            let imageUrl = Info.documentDirectoryChecked.appendingPathComponent(imageName!).appendingPathExtension("jpg")
            try? imageData?.write(to: imageUrl)
            newRestaurant = Info(name: name, address: address, phone: phone, googleLink: URL(string: url), caption: caption, imageName: imageName!, comment: comment, checked: true)
        } else if comment != "有什麼想法呢..." {
            newRestaurant = Info(name: name, address: address, phone: phone, googleLink: URL(string: url), caption: caption, imageName: imageName ?? "", comment: comment, checked: true)
        } else {
            newRestaurant = Info(name: name, address: address, phone: phone, googleLink: URL(string: url), caption: caption, imageName: imageName ?? "", comment: comment, checked: false)
        }
    }
}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        addPhotoBtn.configuration?.background.image = info[.originalImage] as? UIImage
        addPhotoBtn.setTitle("", for: .normal)
        addPhotoBtn.setImage(UIImage(), for: .normal)
        addPhotoBtn.configuration?.background.imageContentMode = .scaleAspectFill
        hasPhoto = true
        dismiss(animated: true)
    }
}

