//
//  ContentView.swift
//  MyFirstApp
//
//  Created by Admin on 03.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        Text("Hello, Mark!")
            .padding()
        Text("It's Emaulator in Emulator,\n but it works well too :)")
            .padding()
        Button(action: {
            self.showingAlert = true
        }) {
            Text("Click me, please!")
        }
        
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Hello!"),
                message: Text("Im an event from btn..."),
                dismissButton: .default(Text("Close me"))
            )

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
