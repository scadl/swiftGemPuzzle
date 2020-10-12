//
//  BoardCellView.swift
//  MyFirstApp
//
//  Created by Admin on 10.10.2020.
//

import SwiftUI

struct BoardCellView: View {
    
    var cellText:String
    var cellSize:CGFloat
    @State var cellColor:Color
    
    let onTo:()->Void
    
    var body: some View {
        HStack{
            Button(cellText, action: {
                actColor()
            }).font(.title)
                .frame(width: cellSize, height: cellSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(cellColor)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
        }
        
    }
    
    func actColor(){
        if(cellColor==Color.blue){
            cellColor = Color.purple
        } else if(cellColor==Color.purple) {
            cellColor = Color.blue
        }
        onTo()
        //print(cellText)
    }
}

struct BoardCellView_Previews: PreviewProvider {
    static var previews: some View {
        BoardCellView(cellText: "#", cellSize: 70, cellColor: Color.blue, onTo: {})
    }
}
