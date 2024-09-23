import SwiftUI
import MapKit

struct WeatherDetailView: View {
    let weatherData: WeatherData?
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        VStack {
            if let weatherData = weatherData {
                // Update the region based on the weatherData coordinates
                Map(coordinateRegion: $region)
                    .onAppear {
                        let newCoordinate = CLLocationCoordinate2D(latitude: weatherData.coord.lat, longitude: weatherData.coord.lon)
                        region = MKCoordinateRegion(center: newCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    }
                    .frame(height: 300)
                    .cornerRadius(10)
                    .padding()
                
                // Weather details
                Text("Weather in \(weatherData.name), \(weatherData.sys.country)")
                    .font(.largeTitle)
                    .padding()
                
                Text("Temperature: \(weatherData.main.temp)°C")
                    .font(.title2)
                
                Text("Description: \(weatherData.weather.first?.description ?? "N/A")")
                    .font(.title2)
                    .padding()
                
                Text("Wind Speed: \(weatherData.wind.speed) m/s")
                    .padding()
                
                Text("Pressure: \(weatherData.main.pressure) hPa")
                    .padding()
                
                Text("Humidity: \(weatherData.main.humidity)%")
                    .padding()
            } else {
                Text("No weather data available.")
            }
        }
        .padding()
        .navigationBarTitle("Weather Details", displayMode: .inline)
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(weatherData: nil)
    }
}

