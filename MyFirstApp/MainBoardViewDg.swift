//
//  MainBoardView.swift
//  MyFirstApp
//
//  Created by scadl on 10.10.2020.
//

import SwiftUI

var numsDg:[String] = []                  // Storage of used number
var counterDg:[Int] = [0,1,2,3]           // Game board cells count and index
let cellSizeDg:CGFloat = 70.0             // Game baord cells size
var dragFirstTick:Bool = true                        // Is thi is first drag tick
var dragStartPoint:CGPoint = CGPoint(x: 0, y: 0)   // Coords of last clicked tile
var rightTurn:Bool = false                           // This turn is right
// Drag limeters
var xPlusLock:CGFloat = 0.0
var xMinusLock:CGFloat = 0.0
var yPlusLock:CGFloat = 0.0
var yMinusLock:CGFloat = 0.0

// A matrix for stroring intal values for board
var cellNumbInitDg = [[Int]](
    repeating: [Int](repeating: 0, count: counterDg.count),
    count: counterDg.count
)

struct MainBoardViewDg: View {
    
    let dragProvider = DragGesture(minimumDistance: 0, coordinateSpace: .local)
    
    // Dictioanry of actual cells values
    @State var cellNumb = [[Int]](
        repeating: [Int](repeating: 0, count: counterDg.count),
        count: counterDg.count
    )
    // Current cell coordinates
    @State var cellCoords = [[CGPoint]](
        repeating: [CGPoint](repeating: CGPoint(x: cellSizeDg/2, y: cellSizeDg/2), count: counterDg.count),
        count: counterDg.count
    )
    @State var shouldUpd = true                                 // UI AutoUpdate flag
    @State var showAlert = false                                // show alert flag
    @State var alertText = [String](repeating: "", count: 3)    //A storage for poupup text
    @State var turnDg:Int = 0                                   // Player turnDgs count
        
    var body: some View {
        
        VStack{
            Text("Current turn: "+String(turnDg)).foregroundColor(.blue)
            VStack(alignment: .center, spacing: 0.0){
                
                // Row building cycle
                ForEach(counterDg, id:\.self){ numRow in
                    
                    HStack(alignment: .center, spacing: 0.0) {
                        // Column building cycle
                        ForEach(counterDg, id:\.self){ numCol in
                            
                            // Generate and store new random number
                            if(shouldUpd){
                                getRandAndRemove(row: numRow, col: numCol)
                            }
                            
                            BoardCellViewDg(
                                cellText: "tile_" + String(cellNumb[numRow][numCol]),
                                cellSize: cellSizeDg
                            )
                            .position(
                                x: cellCoords[numRow][numCol].x,
                                y: cellCoords[numRow][numCol].y
                            ).gesture(dragProvider
                                        .onChanged{
                                            controlDrag(
                                                cursorPos: $0.location,
                                                cellRow: numRow,
                                                cellCol: numCol
                                            )
                                        }
                                        .onEnded{
                                            checkTurn(
                                                cursorPos: $0.location,
                                                cellRow: numRow,
                                                cellCol: numCol
                                            )
                                        }
                            )
                        }
                    }.padding(0.0)
                    
                }.padding(0.0)
                
                // Allow to update the board
                if (shouldUpd){
                    storeBoardValues()
                }
                //let _ = print(cellNumbIDg)
                //let _ = print(cellNumb)
                
            }
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text(alertText[0]),
                    message: Text(alertText[1]),
                    dismissButton: .default(Text(alertText[2]))
                )
            })
            .overlay(
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke().fill(Color.gray)
            )
            .frame(
                width: cellSizeDg*CGFloat(counterDg.count),
                height: cellSizeDg*CGFloat(counterDg.count),
                alignment: .center
            )
        }
        
    }
    
    // Generating non-repeating random numbers
    func getRandAndRemove(row:Int,col:Int)->some View{
        var cur = 0
        while((numsDg.firstIndex(of: String(cur))) != nil){
            cur = Int.random(in: 1...Int(pow(Double(counterDg.count),2))-1)
        }
        numsDg.append(String(cur))
        cellNumbInitDg[row][col] = cur
        return EmptyView()
    }
    
    // Fill game board with generated data
    func storeBoardValues()->some View{
        DispatchQueue.main.async {
            numsDg.removeAll()
            turnDg = 0
            cellNumb = cellNumbInitDg
            shouldUpd = false
        }
        return EmptyView()
    }
    
    func calcAxisVal(cell:Int)->[String:CGFloat]{
        let boardMinAxisVal = cellSizeDg/2 - cellSizeDg*CGFloat(cell)
        let boardMaxAxisVal = (cellSizeDg*CGFloat(counterDg.count-cell))-(cellSize/2)
        return ["min":boardMinAxisVal, "max":boardMaxAxisVal]
    }
    
    // Visible tile move controller
    func controlDrag(cursorPos:CGPoint, cellRow:Int, cellCol:Int){
        
        
        if(dragFirstTick){
            
            // Will invoke only when drag starts
            
            dragStartPoint.x = cellCoords[cellRow][cellCol].x
            dragStartPoint.y = cellCoords[cellRow][cellCol].y
            dragFirstTick = false
            
            // Set move lock to inital position
            xPlusLock = dragStartPoint.x
            xMinusLock = dragStartPoint.x
            yPlusLock = dragStartPoint.y
            yMinusLock = dragStartPoint.y
            // Check for neigbour and alowed move to one tile, if not fall out of values array
            if !(cellCol-1<0) && dragStartPoint.x>calcAxisVal(cell: cellCol)["min"]! {
                if (cellNumb[cellRow][cellCol-1]==0){
                    xPlusLock -= cellSizeDg
                    rightTurn = true
                    print("xPlusLock")
                }
            }
            if !(cellCol+1>counterDg.count) && dragStartPoint.x<calcAxisVal(cell: cellCol)["max"]!{
                if(cellNumb[cellRow][cellCol+1]==0){
                    xMinusLock += cellSizeDg
                    rightTurn = true
                    print("xMinusLock")
                }
            }
            if !(cellRow-1<0) && dragStartPoint.y>calcAxisVal(cell: cellRow)["min"]! {
                if(cellNumb[cellRow-1][cellCol]==0){
                    yPlusLock -= cellSizeDg
                    rightTurn = true
                    print("yPlusLock")
                }
            }
            if !(cellRow+1>counterDg.count) && dragStartPoint.y<calcAxisVal(cell: cellRow)["max"]!{
                if(cellNumb[cellRow+1][cellCol]==0){
                    yMinusLock += cellSizeDg
                    rightTurn = true
                    print("yMinusLock")
                }
            }
        }
        
        // Real drag controller by coords
        if(
            cursorPos.x > xPlusLock &&
                cursorPos.x < xMinusLock
        ){
            cellCoords[cellRow][cellCol].x = cursorPos.x
        }
        if(
            cursorPos.y >  yPlusLock &&
                cursorPos.y < yMinusLock
        ){
            cellCoords[cellRow][cellCol].y = cursorPos.y
        }
        
        print(cursorPos)
    }
    
    // Move ended processor
    func checkTurn(cursorPos:CGPoint, cellRow:Int, cellCol:Int){
        
        //Check if user not finished draging tile and fix it's pos
        if(cursorPos.x < -cellSizeDg/10 && rightTurn){
            cellCoords[cellRow][cellCol].x = (cellSizeDg/2)
            cellNumb[cellRow][cellCol-1] = cellNumb[cellRow][cellCol]
            cellNumb[cellRow][cellCol] = 0
        }
        if(cursorPos.y < -cellSizeDg/10 && rightTurn){
            cellCoords[cellRow][cellCol].y = (cellSizeDg/2)
            cellNumb[cellRow-1][cellCol] = cellNumb[cellRow][cellCol]
            cellNumb[cellRow][cellCol] = 0
        }
        if(cursorPos.x > cellSizeDg+cellSizeDg/10 && rightTurn){
            cellCoords[cellRow][cellCol].x = (cellSizeDg/2)
            cellNumb[cellRow][cellCol+1] = cellNumb[cellRow][cellCol]
            cellNumb[cellRow][cellCol] = 0
        }
        if(cursorPos.y > cellSizeDg+cellSizeDg/10 && rightTurn){
            cellCoords[cellRow][cellCol].y = (cellSizeDg/2)
            cellNumb[cellRow+1][cellCol] = cellNumb[cellRow][cellCol]
            cellNumb[cellRow][cellCol] = 0
        }
        
        if(rightTurn){
            turnDg+=1
        }
        
        // reset turn props
        rightTurn = false
        dragFirstTick = true
        dragStartPoint = CGPoint(x: 0, y: 0)
        
        // check for winner
        let winArray:[[Int]] = [
            [0,1,2,3],
            [4,5,6,7],
            [8,9,10,11],
            [12,13,14,15]
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
        
        print(calcAxisVal(cell: cellRow))
        print(calcAxisVal(cell: cellCol))
        print(cellCoords)
        print(cellNumb)
        
        
    }
    
}

struct MainBoardViewDg_Previews: PreviewProvider {
    static var previews: some View {
        MainBoardViewDg()
    }
}
