//
//  CitiesTableViewCell.swift
//  KrokApp
//
//  Created by Вадим Лавор on 1.08.22.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLogoImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityLogoImageView.layer.cornerRadius = 10
        cityLogoImageView.layer.masksToBounds = true
    }

}
