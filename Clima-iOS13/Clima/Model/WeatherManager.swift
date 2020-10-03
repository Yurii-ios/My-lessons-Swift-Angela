//
//  WeatherManager.swift
//  Clima
//
//  Created by Yurii Sameliuk on 03/11/2019.
//

import Foundation
// importiruem dlia togo 4tobu ispolzowat 
import CoreLocation
// protocol sozdayut w tom klase gde ego ispolzyyut
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=9b6a277834a6cb0fcfd48f14dbb91b5f&units=metric"
    var delegate: WeatherManagerDelegate?
    func fetchWeather(cityName: String) {
        //dobawliaem w konec url adresa nazwanie goroda
        let urlString = "\(weatherURL)&q=\(cityName)"
        // proweriaem w komandnoy stroke wse li rabotaet
         print(urlString)
        performRequest(with: urlString)
    }
  // ispolzyem dlia dodawanija koordinat w konec URL
     func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
           let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
           performRequest(with: urlString)
       }
    
    
    // eta funkcuja bydet wupolniat 4 shaga networkinga
    func performRequest(with urlString: String) {
        //1.Create URL
        
        if  let url = URL(string: urlString) {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            
            //3.Give URLSession a task
            //                                      prinimaet w ka4estwe parametrow metod s 3 parametrami kotoruy mu sozdali
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //peredaem obrabotky oshubor protokoly
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather =  self.parseJSON(weatherData: safeData) {
    
                    // sozdaem deledat 4tobu ispolzovat etot kod mnogakratno, obizatelno pishem self
                    self.delegate?.didUpdateWeather(self, weather: weather)
                     
                    }
                    
                }
            }
            
            //4.Start the task
            // tak kak dataTask wozwras4aet nowyu zada4y mu sozdaem w 3 shage konstanty task, 4tobu wuzwat metodu inicializacii dataTask
            
            task.resume()
            
        }
        
    }
    //konwerturyem JSON format w Swift format
    func parseJSON(weatherData: Data) -> WeatherModel? { // 4tobu mu mogli wernyt nil , nam nado dobawit znak "?"
        let decoder = JSONDecoder()
        do{
       let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
           
        }catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}
