//
//  MainBoardView.swift
//  MyFirstApp
//
//  Created by Admin on 10.10.2020.
//

import SwiftUI

var turn:Int = 0                // Player turns count
var nums:[String] = []          // Storage of used number
var counter:[Int] = [0,1,2,3]           // Game board cells count and index
let cellSize:CGFloat = 70.0             // Game baord cells size
var lastNum = ""                        // Last clicked board cells value
var lastCoord = [Int](repeating: 0, count: 2)   // Coords of last clicked tile

// A matrix for stroring intal values for board
var cellNumbI = [[String]](
    repeating: [String](repeating: "", count: counter.count),
    count: counter.count
)

struct MainBoardView: View {
    
    // Dictioanry of actual cells values
    @State var cellNumb = [[String]](
        repeating: [String](repeating: "#", count: counter.count),
        count: counter.count
    )
    @State var shouldUpd = true         // UI AutoUpdate flag
    @State var showAlert = false        // show alert flag
    @State var alertText = [String](repeating: "", count: 3)
    
    var body: some View {

        VStack{
            Text("Turn: "+String(turn))
            
            // Row building cycle
            ForEach(counter, id:\.self){ numRow in
                
                HStack {
                    // Column building cycle
                    ForEach(counter, id:\.self){ numCol in
                        
                        // Generate and store new random number
                        if(shouldUpd){
                            getRandAndRemove(row: numRow, col: numCol)
                        }
                        
                        BoardCellView(
                                cellText: cellNumb[numRow][numCol]=="0" ? " " : cellNumb[numRow][numCol],
                                cellSize: cellSize,
                            cellColor: cellNumb[numRow][numCol]=="0" ? Color.purple : Color.blue,
                                onTo: {
                                    // click event callback
                                    if (lastNum==""){
                                        // Remember value of first click
                                        lastNum = cellNumb[numRow][numCol]
                                        lastCoord = [numRow, numCol]
                                    } else {
                                        if(
                                            cellNumb[numRow][numCol]=="0" &&
                                            (
                                                (lastCoord[0]==numRow-1 && lastCoord[1]==numCol) ||
                                                (lastCoord[0]==numRow+1 && lastCoord[1]==numCol) ||
                                                (lastCoord[0]==numRow && lastCoord[1]==numCol-1) ||
                                                (lastCoord[0]==numRow && lastCoord[1]==numCol+1)
                                            )
                                        ){
                                            // Write value of first clik to second
                                            cellClickUpd(
                                                newVal: lastNum, oldCoord: lastCoord,
                                                row: numRow, col: numCol)
                                        } else {
                                            // This tiles are not exchangable - reset last click
                                            lastNum = ""
                                            alertText=[
                                                "Error!",
                                                "This is a wrong move",
                                                "OK"
                                            ]
                                            showAlert = true
                                            print("worng move")
                                        }
                                    }
                                }
                        )
                        
                        
                    }
                }.padding(2)
                  
            }
            
            // Allow to update the board
            if (shouldUpd){
                storeBoardValues()
            }
            let _ = print(cellNumbI)
            let _ = print(cellNumb)
            
        }
        
        .alert(isPresented: $showAlert, content: {
            Alert(
                title: Text(alertText[0]),
                message: Text(alertText[1]),
                dismissButton: .default(Text(alertText[2]))
            )
        })
        
    }
    
    // A function for generating non-repeating random numbers
    func getRandAndRemove(row:Int,col:Int)->some View{
        
        var cur = 0
                            
        while((nums.firstIndex(of: String(cur))) != nil){
            cur = Int.random(in: 1...Int(pow(Double(counter.count),2))-1)
        }
        nums.append(String(cur))
        
        cellNumbI[row][col] = String(cur)
        
        return EmptyView()
    }
    
    // Process visual cahnges of current turn
    func cellClickUpd(newVal:String,oldCoord:[Int],row:Int,col:Int){
        cellNumb[row][col] = newVal
        cellNumb[oldCoord[0]][oldCoord[1]] = "0"
        turn += 1
        lastNum = ""
        
        let winArray:[[String]] = [
            ["0","1","2","3"],
            ["4","5","6","7"],
            ["8","9","10","11"],
            ["12","13","14","15"]
        ]
        if(cellNumb==winArray){
            alertText=[
                "Congratulations!",
                "You have successfully found winning combination!",
                "Thanks!"
            ]
            showAlert = true
            // Navigate back?
        }
    }
    
    // Fill game board with generated data
    func storeBoardValues()->some View{
        
        DispatchQueue.main.async {
            nums.removeAll()
            cellNumb = cellNumbI
            shouldUpd = false
        }
        
        return EmptyView()
    }
}

struct MainBoardView_Previews: PreviewProvider {
    static var previews: some View {
        MainBoardView()
    }
}
