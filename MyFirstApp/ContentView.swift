//
//  ContentView.swift
//  MyFirstApp
//
//  Created by Admin on 03.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert:Bool = false
    var icoPadding:CGFloat = 1.0
    
    var body: some View {
        
        VStack {
            
            
            VStack {
                HStack {
                    Image(systemName: "number.square").padding(icoPadding)
                    Image(systemName: "number.square").padding(icoPadding)
                }
                HStack {
                    Image(systemName: "number.square").padding(icoPadding)
                    Image(systemName: "number.square.fill").padding(icoPadding)
                }
            }
            
            Text("Gem Puzzle")
                .font(.headline)
                
            Text("a.k.a. Game of Fifteen")
                .foregroundColor(.gray)
            
            VStack {
                Button(action: {
                    self.showingAlert = true
                }) {
                    HStack{
                        Text("Let's start!")
                        Image(systemName: "play")
                    }
                    .foregroundColor(.white)
                    .padding(10)
                }
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                
                Button(action: {
                    self.showingAlert = true
                }) {
                    HStack{
                        Text("Exit now")
                        Image(systemName: "xmark")
                    }
                    .foregroundColor(.white)
                    .padding(10)
                }
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                
            }.padding()
            
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
