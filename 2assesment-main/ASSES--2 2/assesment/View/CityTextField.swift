//
//  CityTextField.swift
//  assesment
//
//  Created by Volkan Yagci on 8/24/24.
//
import SwiftUI
import UIKit

// A SwiftUI wrapper for UITextField, making it a view
struct CityTextField: UIViewRepresentable {
    @Binding var text: String // Binding to the text entered in the text field
    
    // Coordinator to handle UITextField's delegate methods
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CityTextField

        init(parent: CityTextField) {
            self.parent = parent
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.text = textField.text ?? "" // Update the binding with the text
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // Dismiss the keyboard when return is pressed
            return true
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self) // Create the coordinator to handle delegate callbacks
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = Strings.Placeholders.cityName // Set the placeholder text
        textField.borderStyle = .roundedRect
        textField.delegate = context.coordinator // Set the delegate to the coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text // Update the UITextField with the current binding value
    }
}

