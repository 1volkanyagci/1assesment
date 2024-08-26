import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var cityName: String = ""
    @Published var weatherData: WeatherData?
    
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
}
