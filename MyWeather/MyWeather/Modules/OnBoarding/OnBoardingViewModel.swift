//
//  OnBoardingViewModel.swift
//  MyWeather
//
//  Created by mac on 9/27/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol OnBoardingViewModelOutput {
    
}

protocol OnBoardingViewModelInput {
    
    var pageControlPages: Int { get }
    
    func viewDidLoad()
    func nextPressed()
    func skipPressed()
}

class OnBoardingViewModel: OnBoardingViewModelInput, OnBoardingViewModelOutput {
    
    let pageControlPages: Int = 3
    
    var onBoardingScreens: [OnBoardingModel] = []
    var selectedScreenNo = 0

    var selectedScreen: OnBoardingModel = OnBoardingModel(onBoardingNo: 0, title: "", onBoardingImage: "", type: .sunny)
    var onBoardingScreenObservable = BehaviorSubject<OnBoardingModel>(value: OnBoardingModel(onBoardingNo: 0, title: "", onBoardingImage: "", type: .sunny))

    // let error: Driver<String>

    private let coordinator: OnBoardingCoordinator
    let disposeBag = DisposeBag()
    
    init(coordinator: OnBoardingCoordinator) {
        self.coordinator = coordinator
    }
    
    func viewDidLoad(){
        
        fillOnBoardingScreens()
        bindOnBoardingScreen()
        
    }
    
    func fillOnBoardingScreens() {
        onBoardingScreens.append(OnBoardingModel(onBoardingNo: 1, title: "Get Updated Weather", onBoardingImage: "splash_1_image", type: .sunny))
        onBoardingScreens.append(OnBoardingModel(onBoardingNo: 2, title: "Save Preferred Cities", onBoardingImage: "splash_2_image", type: .rainy))
        onBoardingScreens.append(OnBoardingModel(onBoardingNo: 3, title: "Use Current Location", onBoardingImage: "splash_3_image", type: .fuggy))
        
        selectedScreen = getOnBoardingScreen()
    }
    
    func bindOnBoardingScreen() {
        onBoardingScreenObservable.onNext(selectedScreen)
    }
    
    func nextPressed() {
        if selectedScreenNo < onBoardingScreens.count - 1 {
            selectedScreenNo = selectedScreenNo + 1
            selectedScreen = getOnBoardingScreen()
            onBoardingScreenObservable.onNext(selectedScreen)
        }
        else {
            coordinator.navigateToHome()
        }
    }

    func getOnBoardingScreen() -> OnBoardingModel {
        return onBoardingScreens[selectedScreenNo]
    }

    func skipPressed() {
        coordinator.navigateToHome()
    }

}
