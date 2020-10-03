//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation // importiruem dlia opredelenija tekys4ix koordinat
//UITextFieldDelegate 4tobu wzaemodeictwowat s klawiatyroi tekstFildy
class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    //Объект, для запуска и остановки доставки событий, связанных с местоположением, в ваше приложение
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //минимальное расстояние, которое должен пройти телефон, прежде чем сработает событие обновления (например: 100 метров)
        locationManager.distanceFilter = 100
        
        // sozdaem zapros na razreshenie wkly4enija GPS
        locationManager.requestWhenInUseAuthorization()
        
        //Запрашивает разовую доставку текущего местоположения пользователя
        locationManager.requestLocation()
        
        //specify delegate
        locationManager.delegate = self
        
        //postojannoe otsleguwanie lokacii polzowatejia ( dlia kart i fitnesa)
        //locationManager.startUpdatingLocation()
        
        //obrabatuwaet wwod teksta polzowatelem , kogda polzowatel wzaemodeistwyet s polem wwoda
        weatherManager.delegate = self
        searchTextField.delegate = self
        
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        
    }
    //вызывается при нажатии клавиши возврата w tekstowom pole dla wuzowa etogo metoda w etot moment
    //blagodaria etomy metody na klawiatyre telefona mogem ispolzovat knopky "go" nashego prilogenija
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 4tobu mu mogli skrut klawiatyry posle wwoda w  tekstFilde awtomati4eski, ispolzyem:
        searchTextField.endEditing(true)
        
        print(searchTextField.text!)
        return true
    }
    // izmeniaem podskazky(placeholder) w tekstowom pole kogda polzovatel otkloniaet klawiatyru. etot metod mogna primenit ety prowerky k lybomy tekstowomy poliu w nashem tekys4em kontrollere, rabotaet odnowremenno s mnogimi tekstowumi poliami
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // proweriaem rawen li tekst fild nil
        if textField.text != " "{
            return true
        }
            // esli ne rawen to meniaem podskazky
        else{
            textField.placeholder = "Type something"
            return false
        }
    }
    // metod o4is4aet tekstowoe pole posle ego ispolzowanija, rabotaet kak "searchTextField.endEditing(true)" s klawiatyroy
    func textFieldDidEndEditing(_ textField: UITextField) {
        // pered sbrosom polia mu dolgni poly4ut pogody wwedennogo nami goroda
        //proweriaem ne rawen li nach tekstField nil
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
            
        }
        searchTextField.text = " "
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController:  WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // Main Thread Checker
        //Попытка чтения или обновления пользовательского интерфейса из обработчика завершения может вызвать проблемы
        DispatchQueue.main.async{
            //obnowliaem temperatyry goroda na ekrane
            self.temperatureLabel.text = weather.temeretyrestring
            // obnowliaem kartinky pogodu
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text =  weather.cityName
        }
        
    }
    // obrabatuwaem lyubue oshubki
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // izwlekaem iz masiwa koordinat poslednie koordinatu
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
        weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
 // eta fynkcija nygna obizatelno dlia zapyska prilogenija
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}


