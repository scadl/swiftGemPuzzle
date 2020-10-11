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
    var btnHeigh:CGFloat = 200.0
    var btnRadius:CGFloat = 15.0
    var uiPadding:CGFloat = 5.0
    
    var body: some View {
        
        NavigationView{
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
                
            Text("Game of Fifteen")
                .foregroundColor(.gray)
            
            VStack {
                
                    NavigationLink(
                        destination: MainBoardView(),
                        label: {
                            HStack {
                                Image(systemName: "play")
                                Text("Let's start")
                            }
                            .foregroundColor(.white)
                                .padding(uiPadding)
                                .frame(width: btnHeigh, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: btnRadius))
                        }
                    )
                
                
                
                Button(action: {
                    self.showingAlert = true
                    exit(0)
                }) {
                    HStack{
                        Image(systemName: "xmark")
                        Text("Exit now")
                    }
                    .foregroundColor(.white)
                    .padding(uiPadding)
                    .frame(width: btnHeigh, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: btnRadius))
                
            }.padding()
            
        }
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
