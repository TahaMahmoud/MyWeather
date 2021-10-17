//
//  AddCityViewController.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import UIKit
import RxSwift
import RxCocoa
import GSMessages
import CoreLocation

class AddCityViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var viewModel: AddCityViewModel!

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var citiesSearchResultTableView: UITableView!

    let locationManager = CLLocationManager()
    var currentLocation:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        setupTableView()

        bindSearchTextField()
        bindTableView()
        
        bindMessages()
    }

    @IBAction func selectCurrentLocationPressed(_ sender: Any) {
        startLocation()
    }
    
    @IBAction func backToCitiesPressed(_ sender: Any) {
        viewModel.backToCities()
    }
    
    fileprivate func setupTableView() {
        citiesSearchResultTableView.backgroundColor = .clear
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
                
                //Subscribe to the tap using the proper disposeBag
                cell.addButtonTap
                    .subscribe(onNext: {
                        print("Selected City = \(element.cityName)")
                        self.viewModel.addCity(cityName: element.cityName)
                    })
                    .disposed(by: cell.disposeBag) //Notice it's using the cell's disposableBag and not self.disposeBag

            }
            .disposed(by: disposeBag)
    }
    
    func bindSearchTextField() {
        cityNameTextField.rx.text.orEmpty
            .throttle(RxTimeInterval.seconds(2), latest: true, scheduler: MainScheduler.instance)
                .subscribe(onNext: { text in
                    self.viewModel.fetchCities(cityName: text, latitude: "", longitude: "")
                }, onDisposed: nil)
            .disposed(by: disposeBag)
    }

    func bindMessages() {
        
        viewModel.successMessage.subscribe { [weak self] message in
            self?.showSuccessMessage(message: message)
        }.disposed(by: disposeBag)
        
        viewModel.errorMessage.subscribe { [weak self] message in
            self?.showErrorMessage(message: message)
        }.disposed(by: disposeBag)
        
    }
    
    func showSuccessMessage(message: String) {
        self.showMessage(message, type: .success)
    }
    
    func showErrorMessage(message: String) {
        self.showMessage(message, type: .error)
    }
    
}
