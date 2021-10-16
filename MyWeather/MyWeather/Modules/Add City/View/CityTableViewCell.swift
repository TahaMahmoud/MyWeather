//
//  CityTableViewCell.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import UIKit
import RxSwift

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var addButton: CustomButton!
    
    var disposeBag = DisposeBag()

    var addButtonTap: Observable<Void>{
        return self.addButton.rx.tap.asObservable()
    }
    
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
        self.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }
}
