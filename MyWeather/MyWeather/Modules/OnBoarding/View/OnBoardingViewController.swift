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

    private let pageControlPages = 3

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModel: OnBoardingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.viewDidLoad()
        bindOnBoardingScreen()
        
        // bindUIElements()
    }

    func bindOnBoardingScreen() {
        viewModel.onBoardingScreenObservable.subscribe(onNext: { (onBoardingScreen) in
            self.setupOnBoardingElements(title: onBoardingScreen.title, image: onBoardingScreen.onBoardingImage, screenNo: onBoardingScreen.onBoardingNo, backgroundColor: self.getColor(type: onBoardingScreen.onBoardingType))
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
    
    private func setupUI() {
        self.pageControl.numberOfPages = pageControlPages
    }
    
    private func setupOnBoardingElements(title: String, image: String, screenNo: Int, backgroundColor: UIColor) {
        self.titleLabel.text = title
        self.image.image = UIImage(named: image)
        self.pageControl.currentPage = screenNo - 1
        self.view.backgroundColor = backgroundColor
    }
    
}
