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
        
        setupHoursPickerView()
        bindHoursPickerView()

        viewModel.viewDidLoad()
        
        setupTableView()
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
        hoursPickerView.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    private func bindHoursPickerView() {
        //#1 bind your data to pickerview
        Observable.just(viewModel.hours)
                .bind(to: hoursPickerView.rx.itemTitles) { _, item in
                return item
        }.disposed(by: disposeBag)

        //#2 handle pickerview selection
        hoursPickerView.rx.itemSelected.asObservable().subscribe(onNext: {item in

        //item.row gives you the index of the selected item, so do what you need with                  it

        //also here you can call .resignFirstResponder() on whatever element brought up the pickerview (e.g. a button) in order to close the pickerview

                }).disposed(by: disposeBag)

        //optional: preselect the second item in pickerview
        hoursPickerView.selectRow(1, inComponent: 0, animated: true)
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

}

