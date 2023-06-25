//
//  ContentView.swift
//  Temperature Conversion
//
//  Created by Joseph Roman on 6/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var temperatureAmountInput = 0.0
    @State private var temperatureUnitInput = "Celsius"
    @State private var temperatureUnitOutput = "Fahrenheit"
    
    @State private var temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    @FocusState private var amountIsFocused: Bool
    
    var temperatureAmountOutput: Double {
        var output = 0.0
        
        if temperatureUnitInput == "Celsius" {
            if temperatureUnitOutput == "Fahrenheit" {
                output = (temperatureAmountInput * 9 / 5) + 32
            } else if temperatureUnitOutput == "Kelvin" {
                output = temperatureAmountInput + 273.15
            }
        } else if temperatureUnitInput == "Fahrenheit" {
            if temperatureUnitOutput == "Celsius" {
                output = (temperatureAmountInput - 32) * 5 / 9
            } else if temperatureUnitOutput == "Kelvin" {
                output = (temperatureAmountInput - 32) * 5 / 9 + 273.15
            }
        } else if temperatureUnitInput == "Kelvin" {
            if temperatureUnitOutput == "Celsius" {
                output = temperatureAmountInput - 273.15
            } else if temperatureUnitOutput == "Fahrenheit" {
                output = (temperatureAmountInput - 273.15) * 9 / 5 + 32
            }
        }
        
        return output
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Amount", value: $temperatureAmountInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Unit", selection: $temperatureUnitInput) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Output")) {
                    Text("\(temperatureAmountOutput, specifier: "%.2f")")
                    
                    Picker("Unit", selection: $temperatureUnitOutput) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Temperature Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
