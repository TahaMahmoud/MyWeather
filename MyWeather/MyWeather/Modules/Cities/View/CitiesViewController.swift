//
//  CitiesViewController.swift
//  MyWeather
//
//  Created by mac on 10/13/21.
//

import UIKit
import RxSwift
import RxCocoa
import BLTNBoard

class CitiesViewController: UIViewController {

    private var disposeBag = DisposeBag()
    var viewModel: CitiesViewModel!

    @IBOutlet weak var citiesTableView: UITableView!
    
    let deletePage = BLTNPageItem(title: "Delete City")
    let setDefaultPage = BLTNPageItem(title: "Set Default City")

    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    // For Confirming
    lazy var deleteBulletinManager: BLTNItemManager = {
        let rootItem: BLTNItem = deletePage
        return BLTNItemManager(rootItem: rootItem)
    }()
    
    lazy var setDefaultBulletinManager: BLTNItemManager = {
        let rootItem: BLTNItem = setDefaultPage
        return BLTNItemManager(rootItem: rootItem)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindCachedCities()
        // bindDeleteCities()
        setupTableView()
        
        setupBulletinManager()
        setupDeleteConfirmScreen()
        setupDefaultConfirmScreen()
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidLoad()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        viewModel.backPressed()
    }
    
    @IBAction func addCityPressed(_ sender: Any) {
        viewModel.addCityPressed()
    }
    
    func setupTableView() {
        citiesTableView.delegate = self
        citiesTableView.registerCellNib(cellClass: CityDetailsTableViewCell.self)
        citiesTableView.backgroundColor = .clear
        // citiesTableView.isEditing = true
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

    /* func bindDeleteCities() {
        citiesTableView.rx.itemDeleted
            .subscribe(onNext: { [unowned self] indexPath in
                print(indexPath.row)
                //self.data.value.remove(at: indexPath.row)
            })
            .disposed(by: disposeBag)
    } */
    
    func setupBulletinManager() {
        deleteBulletinManager.backgroundViewStyle = .dimmed
        setDefaultBulletinManager.backgroundViewStyle = .dimmed
    }
    
    func setupDeleteConfirmScreen() {
        deletePage.image = UIImage(named: "delete")

        deletePage.descriptionText = "Are you sure that you want to remove this city? You can't Undo this operation"
        deletePage.actionButtonTitle = "Back"
        deletePage.alternativeButtonTitle = "Remove City"

        let redColor = UIColor(named: "RemoveCityColor")
        deletePage.appearance.actionButtonColor = .systemGreen
        deletePage.appearance.alternativeButtonTitleColor = redColor ?? .systemRed
        deletePage.appearance.actionButtonTitleColor = .white
        
        deletePage.actionHandler = { [weak self] (item: BLTNActionItem) in
            self?.deleteBulletinManager.dismissBulletin(animated: true)
        }

        deletePage.alternativeHandler = { [weak self] (item: BLTNActionItem) in
            self?.viewModel.removeCity(indexPath: self!.selectedIndexPath)
            self?.deleteBulletinManager.dismissBulletin(animated: true)
        }
    }
    
    func setupDefaultConfirmScreen() {
        setDefaultPage.image = UIImage(named: "location")

        setDefaultPage.descriptionText = "Are you sure that you want to set this city as default city?"
        setDefaultPage.actionButtonTitle = "Set Default"
        setDefaultPage.alternativeButtonTitle = "Back"

        let defaultColor = UIColor(named: "DefaultCityColor")
        setDefaultPage.appearance.actionButtonColor = defaultColor ?? .systemBlue
        setDefaultPage.appearance.alternativeButtonTitleColor = defaultColor ?? .systemBlue
        setDefaultPage.appearance.actionButtonTitleColor = .white
    
        setDefaultPage.actionHandler = { [weak self] (item: BLTNActionItem) in
            self?.viewModel.setDefaultCity(indexPath: self!.selectedIndexPath)
            self?.setDefaultBulletinManager.dismissBulletin(animated: true)
        }

        setDefaultPage.alternativeHandler = { [weak self] (item: BLTNActionItem) in
            self?.setDefaultBulletinManager.dismissBulletin(animated: true)
        }

    }

}

