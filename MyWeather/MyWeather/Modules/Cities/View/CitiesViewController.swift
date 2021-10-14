//
//  CitiesViewController.swift
//  MyWeather
//
//  Created by mac on 10/13/21.
//

import UIKit
import RxSwift
import RxCocoa

class CitiesViewController: UIViewController {

    private let disposeBag = DisposeBag()
    var viewModel: CitiesViewModel!

    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindCachedCities()
        
        viewModel.viewDidLoad()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        viewModel.backPressed()
    }
    
    @IBAction func addCityPressed(_ sender: Any) {
        viewModel.addCityPressed()
    }
    
    func setupTableView() {
        citiesTableView.registerCellNib(cellClass: CityDetailsTableViewCell.self)
        citiesTableView.backgroundColor = .clear
    }
    
    func bindCachedCities() {
        
        viewModel.citiesWeather
            .bind(to: citiesTableView.rx.items(
                    cellIdentifier: "CityDetailsTableViewCell",
                    cellType: CityDetailsTableViewCell.self)) { row, element, cell in
                self.citiesTableView.isHidden = false
                let indexPath = IndexPath(row: row, section: 0)
                cell.configure(viewModel: self.viewModel.cityViewModelAtIndexPath(indexPath))
            }
            .disposed(by: disposeBag)
    }

}
