//
//  DayTableViewCell.swift
//  MyWeather
//
//  Created by mac on 10/4/21.
//

import UIKit
import Kingfisher

class DayTableViewCell: UITableViewCell {

    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ viewModel: DayCellViewModel) {
        guard let imageURL = URL(string: viewModel.icon) else {return}
        self.iconImageView.kf.setImage(with: imageURL)
        self.dayNameLabel.text = viewModel.dayName
        self.tempLabel.text = "\(viewModel.temp)"
    }

}
