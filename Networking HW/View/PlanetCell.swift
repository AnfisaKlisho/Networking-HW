//
//  PlanetCell.swift
//  Networking HW
//
//  Created by Anfisa Klisho on 25.11.2020.
//

import UIKit

class PlanetCell: UITableViewCell {
    static let identifier = "PlanetCell"
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var populationLabel: UILabel!
    
    @IBOutlet weak var peopleLabel: UILabel!
    
    @IBOutlet weak var diamLabel: UILabel!
    
    @IBOutlet weak var diameterLabel: UILabel!
    
    @IBOutlet weak var climLabel: UILabel!
    
    @IBOutlet weak var climateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
