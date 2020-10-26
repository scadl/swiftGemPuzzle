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
    var cellColor:LinearGradient        // cell fill color
    var cellBorder:Color                // cell border color
    @State var shouldUpd = true         // UI AutoUpdate flag
    
    let onTo:()->Void
    
    var body: some View {
        
        HStack{
            
            Button(cellText, action: {
                actColor()
            }).font(.title)
                .frame(width: cellSize, height: cellSize, alignment: .center)
                .background(cellColor)
                .foregroundColor(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke().fill(cellBorder))
            
        }
         
        if(shouldUpd){
            //checkZero()
        }
        
    }
    
    func checkZero()->some View{
        DispatchQueue.main.async {
            shouldUpd = false
        }        
        return EmptyView()
    }
    
    func actColor(){
        onTo()
        //print(cellText)
    }
}

struct BoardCellView_Previews: PreviewProvider {
    static var previews: some View {
        BoardCellView(
            cellText: "#",
            cellSize: 70,
            cellColor: LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.init(red: 140/255, green: 189/255, blue: 255/255)]),
                startPoint: .leading, endPoint: .trailing),
            cellBorder: Color.blue,
            onTo: {}
        )
    }
}
