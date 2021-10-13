//
//  AddCityViewController.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class AddCityViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var viewModel: AddCityViewModel!

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var citiesSearchResultTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        setupTableView()

        bindSearchTextField()
        bindTableView()
    }

    @IBAction func selectCurrentLocationPressed(_ sender: Any) {
        
    }
    
    fileprivate func setupTableView() {
        citiesSearchResultTableView.registerCellNib(cellClass: CityTableViewCell.self)
    }

    fileprivate func bindTableView() {
        viewModel.cities
            .bind(to: citiesSearchResultTableView.rx.items(
                    cellIdentifier: "CityTableViewCell",
                    cellType: CityTableViewCell.self)) { row, element, cell in
                self.citiesSearchResultTableView.isHidden = false
                let indexPath = IndexPath(row: row, section: 0)
                cell.configure(self.viewModel.cityViewModelAtIndexPath(indexPath))
            }
            .disposed(by: disposeBag)
    }
    
    func bindSearchTextField() {
        cityNameTextField.rx.text.orEmpty
            .throttle(RxTimeInterval.seconds(2), latest: true, scheduler: MainScheduler.instance)
                .subscribe(onNext: { text in
                    self.viewModel.fetchCities(cityName: text)
                }, onDisposed: nil)
            .disposed(by: disposeBag)
    }

}
