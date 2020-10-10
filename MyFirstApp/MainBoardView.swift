//
//  MainBoardView.swift
//  MyFirstApp
//
//  Created by Admin on 10.10.2020.
//

import SwiftUI

struct MainBoardView: View {
    var body: some View {
        VStack{
        HStack {
            BoardCellView(cellText: "")
            BoardCellView(cellText: "1")
            BoardCellView(cellText: "2")
            BoardCellView(cellText: "3")
        }.padding(3)
        HStack {
            
            BoardCellView(cellText: "4")
            BoardCellView(cellText: "5")
            BoardCellView(cellText: "6")
            BoardCellView(cellText: "7")
        }.padding(3)
        HStack {
            
            BoardCellView(cellText: "8")
            BoardCellView(cellText: "9")
            BoardCellView(cellText: "10")
            BoardCellView(cellText: "11")
        }.padding(3)
            HStack {
                
                BoardCellView(cellText: "12")
                BoardCellView(cellText: "13")
                BoardCellView(cellText: "14")
                BoardCellView(cellText: "15")
            }.padding(3)
        }
    }
}

struct MainBoardView_Previews: PreviewProvider {
    static var previews: some View {
        MainBoardView()
    }
}
