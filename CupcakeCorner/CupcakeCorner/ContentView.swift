//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Hmoo Myat Theingi on 07/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
  
    var body: some View {
        Button("Tap count:\(counter)") {
            counter+=1
        }
        .sensoryFeedback(.error, trigger: counter)
    }
}

#Preview {
    ContentView()
}
