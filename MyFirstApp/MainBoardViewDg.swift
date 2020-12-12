//
//  MainBoardView.swift
//  MyFirstApp
//
//  Created by scadl on 10.10.2020.
//

import SwiftUI

var turnDg:Int = 0                        // Player turnDgs count
var numsDg:[String] = []                  // Storage of used number
var counterDg:[Int] = [0,1,2,3]           // Game board cells count and index
let cellSizeDg:CGFloat = 70.0             // Game baord cells size
var lastNumDg = ""                        // Last clicked board cells value
var lastCoordDg = [Int](repeating: 0, count: 2)   // Coords of last clicked tile

// A matrix for stroring intal values for board
var cellNumbIDg = [[String]](
    repeating: [String](repeating: "", count: counterDg.count),
    count: counterDg.count
)

struct MainBoardViewDg: View {
    
    let dragProvider = DragGesture(minimumDistance: 0, coordinateSpace: .local)
    
    // Dictioanry of actual cells values
    @State var cellNumb = [[String]](
        repeating: [String](repeating: "#", count: counterDg.count),
        count: counterDg.count
    )
    // Current cell coordinates
    @State var cellCoords = [[[CGFloat]]](
        repeating: [[CGFloat]](
                repeating: [CGFloat](
                    repeating:cellSizeDg/2,
                    count:2
                ),
            count: counterDg.count
        ),
        count: counterDg.count
    )
    @State var shouldUpd = true                                 // UI AutoUpdate flag
    @State var showAlert = false                                // show alert flag
    @State var alertText = [String](repeating: "", count: 3)    //A storage for poupup text
    
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
                                x: cellCoords[numRow][numCol][0],
                                y: cellCoords[numRow][numCol][1]
                            ).gesture(dragProvider.onChanged{
                                controlDrag(cursorPos: $0.location, cellRow: numRow, cellCol: numCol)
                            })
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
            lastNumDg = ""
            lastCoordDg = [0,0]
            turnDg = 0
            cellNumb = cellNumbIDg
            shouldUpd = false
        }
        return EmptyView()
    }
    
    // Visible tile move controller
    func controlDrag(cursorPos:CGPoint, cellRow:Int, cellCol:Int){
        let boardMinAxisVal = cellSizeDg/2
        let boardMaxAxisVal = (cellSizeDg*CGFloat(counterDg.count))-(cellSize/2)
        if(cursorPos.x > boardMinAxisVal && cursorPos.x < boardMaxAxisVal){
            cellCoords[cellRow][cellCol][0] = cursorPos.x
        }
        if(cursorPos.y > boardMinAxisVal && cursorPos.y < boardMaxAxisVal){
            cellCoords[cellRow][cellCol][1] = cursorPos.y
        }
        print(cursorPos)
    }
    
}

struct MainBoardViewDg_Previews: PreviewProvider {
    static var previews: some View {
        MainBoardViewDg()
    }
}
