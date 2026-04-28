//
//  VeterinariosTableViewCell.swift
//  VetCare-v1
//
//  Created by XCODE on 27/04/26.
//

import UIKit

class VeterinariosTableViewCell: UITableViewCell {

    @IBOutlet weak var fotovetImageView: UIImageView!
    @IBOutlet weak var nombrevetLabel: UILabel!
    @IBOutlet weak var especialidadvetLabel: UILabel!
    @IBOutlet weak var disponibilidadvetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
