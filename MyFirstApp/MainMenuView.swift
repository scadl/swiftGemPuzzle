//
//  ContentView.swift
//  MyFirstApp
//
//  Created by Admin on 03.10.2020.
//

import SwiftUI

struct MainMenuView: View {
    
    @State private var showingAlert:Bool = false
    var icoPadding:CGFloat = 3
    var btnHeigh:CGFloat = 200.0
    var btnRadius:CGFloat = 15.0
    var uiPadding:CGFloat = 5.0
    var icoCell:CGFloat = 30.0
    
    var body: some View {
        
        NavigationView{
        VStack {
            
            VStack(spacing: icoPadding) {
                HStack(spacing: icoPadding) {
                    Image(systemName: "number.square").resizable().scaledToFit().frame(width: icoCell, height: icoCell)
                    Image(systemName: "number.square").resizable().scaledToFit().frame(width: icoCell, height: icoCell)
                }
                HStack(spacing: icoPadding) {
                    Image(systemName: "number.square").resizable().scaledToFit().frame(width: icoCell, height: icoCell)
                    Image(systemName: "number.square.fill").resizable().scaledToFit().frame(width: icoCell, height: icoCell)
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
                                Text("Let's drop")
                            }
                            .foregroundColor(.white)
                                .padding(uiPadding)
                                .frame(width: btnHeigh, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: btnRadius))
                        }
                    ).navigationTitle("Main menu")
                
                NavigationLink(
                    destination: MainBoardViewDg(),
                    label: {
                        HStack {
                            Image(systemName: "play")
                            Text("Let's drag")
                        }
                        .foregroundColor(.white)
                            .padding(uiPadding)
                            .frame(width: btnHeigh, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: btnRadius))
                    }
                ).navigationTitle("Main menu")
                
                
                
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
        MainMenuView()
    }
}
