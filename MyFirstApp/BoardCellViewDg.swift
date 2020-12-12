//
//  BoardCellView.swift
//  MyFirstApp
//
//  Created by scadl on 10.10.2020.
//

import SwiftUI

struct BoardCellViewDg: View {
    
    var cellText:String                 // Cell label
    var cellSize:CGFloat                // Cell size
    
    var body: some View {
        
        HStack{
            Image(cellText)
                .resizable()
                .scaledToFit()
                .frame(
                    width: cellSize,
                    height: cellSize,
                    alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke()
                        .fill(Color.gray)
                )               
            
        }
        
    }
        
}

struct BoardCellViewDg_Previews: PreviewProvider {
    static var previews: some View {
        BoardCellView(
            cellText: "#",
            cellSize: 70,
            cellColor: Image("cellBg"),
            cellBorder: Color.blue
        )
    }
}
