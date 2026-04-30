//
//  CitaTableViewCell.swift
//  VetCare-v1
//
//  Created by XCODE on 29/04/26.
//

import UIKit

class CitaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNombreMascota: UILabel!
        @IBOutlet weak var lblNombreDueño: UILabel!
        @IBOutlet weak var lblFecha: UILabel!
        @IBOutlet weak var lblHora: UILabel!
        @IBOutlet weak var lblMotivo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
