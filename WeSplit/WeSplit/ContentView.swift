//
//  ContentView.swift
//  WeSplit
//
//  Created by Hmoo Myat Theingi on 26/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var people = 2
    @State private var tipPercentage = 10

    @FocusState private var isFocused:Bool

    
    var currencyFormat : FloatingPointFormatStyle<Double>.Currency{
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    
    var totalAmount:Double{
        let checkAmount = Double(amount)
        let peopleCount = Double(people+2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount+tipValue
        let total = grandTotal/peopleCount

        return total
    }
    
    var amountPerPerson:Double{
        let checkAmount = Double(amount)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount+tipValue

        return grandTotal
    }
    
    
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Enter your amount",value: $amount,format:currencyFormat).keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of people", selection: $people) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0 ,format: .percent)
                        }
                    }
                }header: {
                    Text("How much do you want to leave?")
                }
                Section {
                    Text(totalAmount,format:currencyFormat)
                }header: {
                    Text("Total amount")
                }
                Section {
                    Text(amountPerPerson,format:currencyFormat)
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                }header: {
                    Text("Amount per person")
                }
            }.navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement:.keyboard) {
                        Spacer()
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
