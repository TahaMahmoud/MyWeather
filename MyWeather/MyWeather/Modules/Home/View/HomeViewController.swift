//
//  HomeViewController.swift
//  MyWeather
//
//  Created by mac on 10/4/21.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import CoreLocation

class HomeViewController: UIViewController {
    
    internal var hours: [String] = []
    
    let disposeBag = DisposeBag()
    var viewModel: HomeViewModel!

    let locationManager = CLLocationManager()

    var latitude: String = ""
    var longitude: String  = ""
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var hoursPickerView: UIPickerView!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    
    @IBOutlet weak var daysTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupHoursPickerView()

        setupTableView()
        
        bindCityName()
        bindHoursPickerView()
        bindCurrentWeather()
        bindTableView()
        
        bindRequestLocation()

    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidLoad()
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        viewModel.settingsPressed()
    }
    
    @IBAction func citiesPressed(_ sender: Any) {
        viewModel.citiesPressed()
    }

    private func setupHoursPickerView() {
        hoursPickerView.setValue(UIColor.white, forKeyPath: "textColor")
    }

    func bindCityName() {
        viewModel.weather.subscribe { [weak self] weather in
            self?.cityNameLabel.text = weather.element?.location?.name?.uppercased() ?? ""
        }.disposed(by: disposeBag)
    }
    
    func bindCurrentWeather() {
        viewModel.currentHour.subscribe { [weak self] hour in
            self?.setupCurrentWeatherUI(data: (self?.viewModel.hourWeatherAt(hour.element?.time ?? "12:00 AM")) ?? (time: "12:00", temp: 0, condition: "", icon: ""))
            
            // Select the index of current hour in uipickerview
            self?.hoursPickerView.selectRow(self?.viewModel.getIndexFrom(time: hour.element?.time ?? "12:00 AM") ?? 0, inComponent: 0, animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func bindHoursPickerView() {       
                
        viewModel.hours
            .bind(to: hoursPickerView.rx.itemTitles) { _, item in
                return item.time
        }.disposed(by: disposeBag)

        //optional: preselect the second item in pickerview

        hoursPickerView.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] item in
            self?.setupCurrentWeatherUI(data: self?.viewModel.hourWeatherAt(item.row) ?? (time: "12:00", temp: 0, condition: "", icon: "") )
        }).disposed(by: disposeBag)

    }
    
    fileprivate func setupTableView() {
        daysTableView.registerCellNib(cellClass: DayTableViewCell.self)
    }

    fileprivate func bindTableView() {
        viewModel.days
            .bind(to: daysTableView.rx.items(
                    cellIdentifier: "DayTableViewCell",
                    cellType: DayTableViewCell.self)) { row, element, cell in
                let indexPath = IndexPath(row: row, section: 0)
                cell.configure(self.viewModel.daysViewModelAtIndexPath(indexPath))
            }
            .disposed(by: disposeBag)
    }
    
    func setupCurrentWeatherUI(data: HourData) {
        currentTempLabel.text = "\(data.temp)"
        weatherStateLabel.text = data.condition
        
        guard let imageURL = URL(string: data.icon) else {return}
        currentWeatherImageView.kf.setImage(with: imageURL)

    }
        
}
