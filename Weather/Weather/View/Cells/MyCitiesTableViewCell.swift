//
//  MyCitiesTableViewCell.swift
//  Weather
//
//  Created by Vlad on 04.08.2021.
//

import UIKit

final class MyCitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var myCityNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
