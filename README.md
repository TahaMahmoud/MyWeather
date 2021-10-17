# MyWeather

MyWeather is a simple iOS application, it retrieves Current Weather Data from free API [weatherapi.com] and display them for the user, and allow the user to view more weather details.

Using [weatherapi.com](https://www.weatherapi.com)

## Used In The APP
- SWIFT
- Alamofire-based Network Layer
- MVVM Architecture Pattern
- Coordinator Pattern For Handling Navigation
- RxSwift, RxCocoa For Data Binding
- Kingfisher For Images Downloading and Caching
- XIB Files
- CoreLocation For Detecting Current Location
- CoreData For Caching Prefered Cities 
- Adobe XD For Designing The UI

## Screenshots
- Launch Screen
<img src="/Screenshots/LaunchScreen.png" width="200" height="400">

- OnBoarding Screen 1
<img src="/Screenshots/OnBoarding1.png" width="200" height="400">

- OnBoarding Screen 2
<img src="/Screenshots/OnBoarding2.png" width="200" height="400">

- OnBoarding Screen 3
<img src="/Screenshots/OnBoarding3.png" width="200" height="400">

- Get First-Time Current Location ( If No Default City )
<img src="/Screenshots/GetLocation.png" width="200" height="400">

- Get Current Weather ( With Location )
<img src="/Screenshots/CurrentWeatherWithLocation.png" width="200" height="400">

- Saved Cities
<img src="/Screenshots/CitiesList.png" width="200" height="400">

- Add New City ( Search With City Name )
<img src="/Screenshots/AddCityWithCityName.png" width="200" height="400">

- Add New City ( Detect Current Location )
<img src="/Screenshots/AddCityWithLocation.png" width="200" height="400">

- Set Specific City As The Default City 
<img src="/Screenshots/SetDefaultCity.png" width="200" height="400">

- Set Specific City As The Default City ( Confirmation )
<img src="/Screenshots/SetDefaultCityConfirm.png" width="200" height="400">

- Get Current Weather ( With Default City )
<img src="/Screenshots/CurrentWeatherWithDefaultCity.png" width="200" height="400">

- Delete City 
<img src="/Screenshots/DeleteCity.png" width="200" height="400">

- Delete City ( Confirmation )
<img src="/Screenshots/DeleteCityConfirm.png" width="200" height="400">


## App Structure:
* App
   * Configuration
   * Core
   * Extensions
   * Resources
      * Fonts
   * SupportingFiles
   * Externals
      * Coordinator
      * Networking
      * Core Data

* Modules
   * OnBoarding
      * Model
      * View
      * ViewModel
      * Coordinator
      * Interactor
   * Home
      * Model
      * View
      * ViewModel
      * Coordinator
   * Cities
       * Model
       * View
       * ViewModel
       * Coordinator
       * Interactor
   * AddCity
       * Model
       * View
       * ViewModel
       * Coordinator
       * Interactor

## Authors:
Created by 
- Taha Mahmoud [LinkedIn](https://www.linkedin.com/in/engtahamahmoud/)

Please don't hesitate to ask any clarifying questions about the project if you have any.
