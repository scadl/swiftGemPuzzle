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

// A matrix for stroring intal values for board
var cellNumbIDg = [[String]](
    repeating: [String](repeating: "", count: counterDg.count),
    count: counterDg.count
)

struct MainBoardViewDg: View {
    
    
    let dragProvider = DragGesture(minimumDistance: 0, coordinateSpace: .local)
    
    // Dictioanry of actual cells values
    @State var cellNumb = [[String]](
        repeating: [String](repeating: "", count: counterDg.count),
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
            Text("Current turn: "+String(turnDg)).foregroundColor(.blue).padding(3)
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
                                cellText: "tile_" + cellNumb[numRow][numCol],
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
        cellNumbIDg[row][col] = String(cur)
        return EmptyView()
    }
    
    // Fill game board with generated data
    func storeBoardValues()->some View{
        DispatchQueue.main.async {
            numsDg.removeAll()
            turnDg = 0
            cellNumb = cellNumbIDg
            shouldUpd = false
        }
        return EmptyView()
    }
    
    func calcAxisVal(cell:Int)->[String:CGFloat]{
        let boardMinAxisVal = cellSizeDg/2 - cellSizeDg*CGFloat(cell)
        let boardMaxAxisVal = (cellSizeDg*CGFloat(counterDg.count-cell))-(cellSize/2)
        return ["min":boardMinAxisVal+5, "max":boardMaxAxisVal+5]
    }
    
    // Visible tile move controller
    func controlDrag(cursorPos:CGPoint, cellRow:Int, cellCol:Int){
        
        
        if(dragFirstTick){
            dragStartPoint.x = cellCoords[cellRow][cellCol].x
            dragStartPoint.y = cellCoords[cellRow][cellCol].y
            dragFirstTick = false
        }
        
        // Check for neigbour and calc alowed move trajectory
        var xPlusLock:CGFloat = dragStartPoint.x
        var xMinusLock:CGFloat = dragStartPoint.x
        var yPlusLock:CGFloat = dragStartPoint.y
        var yMinusLock:CGFloat = dragStartPoint.y
        if !(cellCol-1<0) && dragStartPoint.x>calcAxisVal(cell: cellCol)["min"]! {
            xPlusLock = cellNumb[cellRow][cellCol-1]=="0"
                ? xPlusLock-cellSizeDg
                : xPlusLock
        }
        if !(cellCol+1>counterDg.count) && dragStartPoint.x>calcAxisVal(cell: cellCol)["max"]!{
            xMinusLock = cellNumb[cellRow][cellCol+1]=="0"
                ? xMinusLock+cellSizeDg
                : xMinusLock
        }
        if !(cellRow-1<0) && dragStartPoint.y>calcAxisVal(cell: cellRow)["min"]! {
            yPlusLock = cellNumb[cellRow-1][cellCol]=="0"
                ? yPlusLock-cellSizeDg
                : yPlusLock
        }
        if !(cellRow+1>counterDg.count) && dragStartPoint.y>calcAxisVal(cell: cellRow)["max"]!{
            yMinusLock = cellNumb[cellRow+1][cellCol]=="0"
                ? yMinusLock+cellSizeDg
                : yMinusLock
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
    
    func checkTurn(cursorPos:CGPoint, cellRow:Int, cellCol:Int){
        turnDg += 1
        dragFirstTick = true
        dragStartPoint = CGPoint(x: 0, y: 0)
    }
    
}

struct MainBoardViewDg_Previews: PreviewProvider {
    static var previews: some View {
        MainBoardViewDg()
    }
}
