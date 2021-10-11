//
//  CityTableViewCell.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ viewModel: CityCellViewModel) {
        cityNameLabel.text = viewModel.cityName
    }

    @IBAction func addCityPressed(_ sender: Any) {
        
    }
    
}
