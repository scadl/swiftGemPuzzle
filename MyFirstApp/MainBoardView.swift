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
var lastCoord = [Int](repeating: 0, count: 2)
//var shouldUpd = true

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
    @State var shouldUpd = true
    
    var body: some View {

        VStack{
            Text("Turn: "+String(turn))
            
            // Row building cycle
            ForEach(counter, id:\.self){ numRow in
                
                let _ = print("r:"+String(numRow))
                
                HStack {
                    // Column building cycle
                    ForEach(counter, id:\.self){ numCol in
                        
                        let _ = print("c:"+String(numCol))
                        
                        // Generate and store new random number
                        if(shouldUpd){
                        getRandAndRemove(row: numRow, col: numCol)
                        }
                        
                        BoardCellView(
                                cellText: cellNumb[numRow][numCol]=="0" ? " " : cellNumb[numRow][numCol],
                                cellSize: cellSize,
                                cellColor: cellNumb[numRow][numCol]=="0" ? Color.gray : Color.blue,
                                onTo: {
                                    print("click "+cellNumb[numRow][numCol])
                                    if (lastNum==""){
                                        lastNum = cellNumb[numRow][numCol]
                                        lastCoord = [numRow, numCol]
                                    } else {
                                        if(cellNumb[numRow][numCol]=="0"){
                                            cellClickUpd(
                                                newVal: lastNum, oldCoord: lastCoord,
                                                row: numRow, col: numCol)
                                        } else {
                                            let _ = print("wrong move")
                                            lastNum = ""
                                        }
                                    }
                                }
                        )
                        
                        
                    }
                }.padding(2)
                  
            }
            
            if (shouldUpd){
                storeBoardValues()
            }
            let _ = print(cellNumbI)
            let _ = print(cellNumb)
            
        }
       
        
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
    
    
    func cellClickUpd(newVal:String,oldCoord:[Int],row:Int,col:Int){
        cellNumb[row][col] = newVal
        cellNumb[oldCoord[0]][oldCoord[1]] = "0"
        lastNum = ""
        //nums.removeAll()
    }
    
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
