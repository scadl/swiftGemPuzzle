//
//  BoardCellView.swift
//  MyFirstApp
//
//  Created by scadl on 10.10.2020.
//

import SwiftUI

struct BoardCellView: View {
    
    var cellText:String                 // Cell label
    var cellSize:CGFloat                // Cell size
    var cellColor:Image        // cell fill color
    var cellBorder:Color                // cell border color
    
    var body: some View {
        
        HStack{
            
            HStack{
                Text(cellText)
            }.font(.title)
            .frame(width: cellSize, height: cellSize, alignment: .center)
            .background(cellColor.resizable().scaledToFit())
            .foregroundColor(.white)
            .overlay(Rectangle().stroke().fill(cellBorder))
            
        }
        
    }
        
}

struct BoardCellView_Previews: PreviewProvider {
    static var previews: some View {
        BoardCellView(
            cellText: "#",
            cellSize: 70,
            cellColor: Image("cellBg"),
            cellBorder: Color.blue
        )
    }
}
