//
//  MascotaTableViewCell.swift
//  VetCare-v1
//
//  Created by XCODE on 24/04/26.
//

import UIKit

class MascotaTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var fotoMascotImage: UIImageView!
    
    @IBOutlet weak var nombreMascotaLabel: UILabel!
    
    @IBOutlet weak var especieMascotaLabel: UILabel!
    
    @IBOutlet weak var edadMascotaLabel: UILabel!
}
