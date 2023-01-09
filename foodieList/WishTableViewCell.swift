//
//  WishTableViewCell.swift
//  foodieList
//
//  Created by Jube on 2023/1/6.
//

import UIKit

class WishTableViewCell: UITableViewCell {

    @IBOutlet weak var unCheckBtn: UIButton!
    @IBOutlet weak var wishNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
