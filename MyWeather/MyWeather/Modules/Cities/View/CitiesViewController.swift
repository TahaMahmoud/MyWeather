//
//  CitiesViewController.swift
//  MyWeather
//
//  Created by mac on 10/13/21.
//

import UIKit
import RxSwift

class CitiesViewController: UIViewController {

    private let disposeBag = DisposeBag()
    var viewModel: CitiesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
}
