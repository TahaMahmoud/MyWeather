//
//  HomeViewController.swift
//  MyWeather
//
//  Created by mac on 10/4/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    
    @IBOutlet weak var hoursPickerView: UIPickerView!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    
    @IBOutlet weak var daysTableView: UITableView!
    
    internal var hours: [String] = []
    
    private let disposeBag = DisposeBag()
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
        setupHoursPickerView()

        setupTableView()
        
        bindHoursPickerView()
        bindTableView()
        
    }

    @IBAction func settingsPressed(_ sender: Any) {
        viewModel.settingsPressed()
    }
    
    @IBAction func addCityPressed(_ sender: Any) {
        viewModel.addCityPressed()
    }

    private func setupHoursPickerView() {
        hoursPickerView.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    private func bindHoursPickerView() {

        viewModel.hours.asObservable().subscribe(onDisposed:  { () in
            self.setupCurrentWeatherUI(data: self.viewModel.hourWeatherAt(self.viewModel.getCurrentHour()))
        }).disposed(by: disposeBag)
        

        viewModel.hours
            .bind(to: hoursPickerView.rx.itemTitles) { _, item in
                return item.date
        }.disposed(by: disposeBag)

        //optional: preselect the second item in pickerview
        hoursPickerView.selectRow(1, inComponent: 0, animated: true)

        
        hoursPickerView.rx.itemSelected.asObservable().subscribe(onNext: {item in
            self.setupCurrentWeatherUI(data: self.viewModel.hourWeatherAt(item.row))
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
    }
}

