//
//  OnBoardingViewController.swift
//  MyWeather
//
//  Created by mac on 9/27/21.
//

import UIKit
import RxSwift
import RxCocoa

class OnBoardingViewController: UIViewController {

    private let pageControlCount = 3

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModel: OnBoardingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        bindOnBoardingScreen()
        
        // bindUIElements()
    }

    func bindOnBoardingScreen() {
        viewModel.onBoardingScreenObservable.subscribe(onNext: { (onBoardingScreen) in
            self.setupUI(title: onBoardingScreen.title, image: onBoardingScreen.onBoardingImage, screenNo: onBoardingScreen.onBoardingNo, backgroundColor: self.getColor(onBoardingScreenType: onBoardingScreen.onBoardingType))
        }).disposed(by: disposeBag)
    }
    
    func bindUIElements() {
        
        nextBtn.rx.tap.subscribe{ [weak self] event in
            self?.viewModel.nextPressed()
        }
        .disposed(by: disposeBag)
        
        
        skipBtn.rx.tap.subscribe{ [weak self] event in
            self?.viewModel.skipPressed()
        }
        .disposed(by: disposeBag)

    }

    @IBAction func nextPressed(_ sender: Any) {
        viewModel.nextPressed()
    }
    
    @IBAction func skipPressed(_ sender: Any) {
        viewModel.skipPressed()
    }
    
    private func setupUI(title: String, image: String, screenNo: Int, backgroundColor: UIColor) {
        self.titleLabel.text = title
        self.image.image = UIImage(named: image)
        self.pageControl.currentPage = screenNo - 1
        self.view.backgroundColor = backgroundColor
    }
    
    private func getColor(onBoardingScreenType: OnBoardingType) -> UIColor {
        switch onBoardingScreenType {
        case .sunny:
            return UIColor(named: "SunnyColor") ?? UIColor.systemOrange
        case .rainy:
            return UIColor(named: "RainyColor") ?? UIColor.systemBlue
        case .fuggy:
            return UIColor(named: "FuggyColor") ?? UIColor.systemGray
        default:
            return UIColor(named: "SunnyColor") ?? UIColor.systemOrange
        }
    }
}
