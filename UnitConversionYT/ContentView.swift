//
//  ContentView.swift
//  UnitConversionYT
//
//  Created by RobiOSDev
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = ""
    @State private var inputUnit: UnitLength = .meters
    @State private var outputUnit: UnitLength = .kilometers
    @State private var convertedValue: Double?

    let lengthUnits: [UnitLength] = [.meters, .kilometers, .miles]

    var formattedConvertedValue: String {
        if let value = convertedValue {
            return String(format: "%.2f", value)
        } else {
            return "0.00"
        }
    }

    func convertValue() {
        guard let value = Double(inputValue) else { return }
        let inputMeasurement = Measurement(value: value, unit: inputUnit)
        convertedValue = inputMeasurement.converted(to: outputUnit).value
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Enter Value") {
                    TextField("Value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }
                Picker("Input Unit", selection: $inputUnit) {
                    ForEach(lengthUnits, id: \.self) {
                        Text("\($0.symbol)")
                    }
                }
                .pickerStyle(.segmented)

                Picker("Output Unit", selection: $outputUnit) {
                    ForEach(lengthUnits, id: \.self) {
                        Text("\($0.symbol)")
                    }
                }
                .pickerStyle(.segmented)

                Section("Converted Value") {
                    Text("\(formattedConvertedValue) \(outputUnit.symbol)")
                }
            }
            .navigationTitle("Unit Converter")
        }
        .onChange(of: inputValue) { convertValue() }
        .onChange(of: inputUnit) { convertValue() }
        .onChange(of: outputUnit) { convertValue() }
    }
}

#Preview {
    ContentView()
}
