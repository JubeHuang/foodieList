//
//  EditInfoTableViewCell.swift
//  foodieList
//
//  Created by Jube on 2023/1/7.
//

import UIKit

@objc protocol TableViewDelegate: NSObjectProtocol{

    func afterClickingReturnInTextField(cell: EditInfoTableViewCell)
    
}

class EditInfoTableViewCell: UITableViewCell {

    var infoLabels = ["地址","電話","GoogleMap","備註"]
    
    @IBOutlet weak var userFillTextfield: UITextField!
    weak var tableViewDelegate: TableViewDelegate?
    @IBOutlet weak var nameInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapTextfield(_ sender: UITextField) {
        tableViewDelegate?.responds(to:#selector(TableViewDelegate.afterClickingReturnInTextField(cell:)))
        tableViewDelegate?.afterClickingReturnInTextField(cell: self)
    }
    

}

extension EditInfoTableViewCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userFillTextfield.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        userFillTextfield = textField
    }
}
