import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    
    @Published var cityName: String = ""  {
        didSet {
            UserDefaults.standard.set(cityName, forKey: "lastSearchedCity")
        }
    }
    init() {
        loadLastSearchedCity()
        fetchWeatherIcons()
    }
    @Published var weatherData: WeatherData?
    @Published var weatherIconURLs: [WeatherIcon: String] = [:]
    private var networkManager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    
    
    func fetchWeather(completion: @escaping (Bool) -> Void) {
        networkManager.getWeather(for: cityName) { success in
            if success {
                self.networkManager.$weatherData
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] weatherData in
                        self?.weatherData = weatherData
                    }
                    .store(in: &self.cancellables)
            }
            completion(success)
        }
    }
    
    private func loadLastSearchedCity() {
        if let lastCity = UserDefaults.standard.string(forKey: "lastSearchedCity") {
            cityName = lastCity
        }
    }
    func fetchWeatherIcons() {
        let allWeatherIcons: [WeatherIcon] = [
            .clearDay
        ]
                for icon in allWeatherIcons {
            weatherIconURLs[icon] = icon.iconURL
        }
    }
        func getWeatherIconURL(for icon: WeatherIcon) -> String {
        return weatherIconURLs[icon] ?? ""
    }
}
