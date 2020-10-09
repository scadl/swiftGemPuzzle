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
        
        VStack {
            
            Image(systemName: "homekit")
            Text("Hello, Mark!")
                .padding(5)
            
            Text("It's Emaulator in Emulator,\n but it works well too :)")
                .foregroundColor(.red)
                .padding()
            
            Button(action: {
                self.showingAlert = true
            }) {
                HStack{
                    Image(systemName: "exclamationmark.icloud")
                    Text("Click me, please!")
                }
                .foregroundColor(.white)
                .padding(10)
            }
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .shadow(radius: 15 )
            .overlay(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .stroke(Color.white, lineWidth: 3)
            )
            
            Text("And as you can see, \nI can do some basic things with the UI")
                .multilineTextAlignment(.center)
                .padding()
                .font(.footnote)
                .foregroundColor(.blue)
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
