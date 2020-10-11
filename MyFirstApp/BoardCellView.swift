//
//  BoardCellView.swift
//  MyFirstApp
//
//  Created by Admin on 10.10.2020.
//

import SwiftUI

struct BoardCellView: View {
    
    var cellText:String
    var cellColor:Color
    var cellSize:CGFloat
    
    var body: some View {
        HStack{
            Text(cellText)
                .font(.title)
                .frame(width: cellSize, height: cellSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(cellColor)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
        }
        
    }
}

struct BoardCellView_Previews: PreviewProvider {
    static var previews: some View {
        BoardCellView(cellText: "#", cellColor: Color.blue, cellSize: 70)
    }
}
