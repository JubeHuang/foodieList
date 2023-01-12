//
//  CheckdTableViewCell.swift
//  foodieList
//
//  Created by Jube on 2023/1/6.
//

import UIKit

class CheckdTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var checkedNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
