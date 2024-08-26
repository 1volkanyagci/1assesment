import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @State private var showWeatherDetail: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            Map()
            HStack {
               
                TextField("City name", text: $viewModel.cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    print("Button clicked")
                    viewModel.fetchWeather { success in
                        if success {
                            showWeatherDetail = true
                            print("Weather data fetched successfully")
                        } else {
                            showAlert = true
                        }
                    }
                }) {
                    Text("Get Weather")
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding()
                .alert("Invalid City", isPresented: $showAlert) {
                                  Button("OK", role: .cancel) {}
                              } message: {
                                  Text("Please enter a valid U.S.city name.")
                              }
                // Updated NavigationLink to use the new API
                .navigationDestination(isPresented: $showWeatherDetail) {
                    if let weatherData = viewModel.weatherData {
                        WeatherDetailView(weatherData: weatherData)
                    } else {
                        Text("No weather data available.")
                    }
                }
            }
            .padding()
            .navigationBarTitle("Weather App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

