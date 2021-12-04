//
//  BudgetCell.swift
//  WalletBud
//
//  Created by Sohil Shrestha on 12/4/21.
//

import UIKit

class BudgetCell: UITableViewCell {

    @IBOutlet weak var budgettextField: UITextField!
    @IBOutlet weak var HashTagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
