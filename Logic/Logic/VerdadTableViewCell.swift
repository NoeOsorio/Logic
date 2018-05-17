//
//  VerdadTableViewCell.swift
//  Logic
//
//  Created by Noe Osorio on 16/05/18.
//  Copyright © 2018 Noe Osorio. All rights reserved.
//

import UIKit

class VerdadTableViewCell: UITableViewCell {

    @IBOutlet var premisa: UILabel!
    @IBOutlet var estado: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
