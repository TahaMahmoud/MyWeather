//
//  CityDetailsTableViewCell.swift
//  MyWeather
//
//  Created by mac on 10/13/21.
//

import UIKit
import Kingfisher

class CityDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: CityDetailsCellViewModel) {
        cityLabel.text = viewModel.cityName
        guard let imageURL = URL(string: viewModel.icon) else {return}
        self.iconImageView.kf.setImage(with: imageURL)
        self.tempLabel.text = "\(viewModel.currentTemp)"
        
        self.backgroundColor = .clear
    }

}
