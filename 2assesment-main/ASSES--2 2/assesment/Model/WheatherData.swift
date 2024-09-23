import Foundation

struct WeatherData: Codable, Hashable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let name: String
    
    struct Coord: Codable, Hashable {
        let lon: Double
        let lat: Double
    }
    
    struct Weather: Codable, Hashable {
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable, Hashable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }
    
    struct Wind: Codable, Hashable {
        let speed: Double
        let deg: Int
    }
    
    struct Sys: Codable, Hashable {
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}

