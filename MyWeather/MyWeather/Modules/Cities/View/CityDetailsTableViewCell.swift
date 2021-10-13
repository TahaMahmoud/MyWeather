//
//  CityDetailsTableViewCell.swift
//  MyWeather
//
//  Created by mac on 10/13/21.
//

import UIKit

class CityDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(cityName: String, icon: String, temp: Double) {
        
    }
}
