import Foundation
import MapKit

class NetworkManager: ObservableObject {
    
    // API Key
    private let apiKey = "a209dd5f2bb7febab474c93cae991402"
    // Base URL for the APIs
    private let geoBaseURL = "http://api.openweathermap.org/geo/1.0/direct"
    private let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    // Published property to store fetched weather data
    @Published var weatherData: WeatherData?
    
    // Function to fetch latitude and longitude based on city name
    func fetchLatLon(for cityName: String, completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        
        // Construct the Geo API URL
        let urlString = "\(geoBaseURL)?q=\(cityName),US&limit=1&appid=\(apiKey)"
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        // Create the data task to fetch lat/lon
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Handle errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure data is received
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            // Decode the JSON data
            do {
                let geoResponse = try JSONDecoder().decode([GeoResponse].self, from: data)
                if let firstResult = geoResponse.first {
                    completion(.success((firstResult.lat, firstResult.lon)))
                } else {
                    completion(.failure(NSError(domain: "No results", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start the task
        task.resume()
    }
    
    // Function to fetch weather data
    func fetchWeather(lat: Double, lon: Double) {
        
        // Create the full URL with query parameters
        let urlString = "\(weatherBaseURL)?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create the data task to fetch weather data
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Handle errors
            if let error = error {
                print("Error fetching weather: \(error.localizedDescription)")
                return
            }
            
            // Ensure data is received
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Decode the JSON data
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                
                // Update the published property on the main thread
                DispatchQueue.main.async {
                    self.weatherData = weatherData
                }
                
            } catch {
                print("Error decoding weather data: \(error.localizedDescription)")
            }
        }
        
        // Start the task
        task.resume()
    }
    
    // Combined function to get weather data based on city name
    func getWeather(for cityName: String, completion: @escaping (Bool) -> Void) {
        fetchLatLon(for: cityName) { result in
            switch result {
            case .success(let (lat, lon)):
                self.fetchWeather(lat: lat, lon: lon)
                completion(true)
            case .failure(let error):
                print("Error fetching lat/lon: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
 
    
}

