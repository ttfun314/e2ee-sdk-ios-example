//
//  ContentView.swift
//  Hello World
//
//  Created by Thien Nguyen on 6/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, thien!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
