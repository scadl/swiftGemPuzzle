//
//  MainBoardView.swift
//  MyFirstApp
//
//  Created by Admin on 10.10.2020.
//

import SwiftUI

var turn:Int = 0                // Player turns count
var nums:[String] = []          // Storage of used number
var counter:[Int] = [1,2,3,4]           // Game board cells count
let cellSize:CGFloat = 70.0             // Game baord cells size
var shouldUpdate = true

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
                        
                        getRandAndRemove(row: numRow, col: numCol)
                        
                        let cVal = cellNumb[numRow-1][numCol-1]
                        let curColor = cVal=="0" ? Color.gray : Color.blue
                        let curNum = cVal=="0" ? " " : cVal
                        BoardCellView(
                                cellText: curNum,
                                cellSize: cellSize,
                                cellColor: curColor,
                                onTo: {
                                    print("click "+cVal)
                                }
                        )
                        
                        
                        
                    }
                }.padding(2)
                  
            }
            
            if !(cellNumbI==cellNumb){
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
        
        cellNumbI[row-1][col-1] = String(cur)
        
        return EmptyView()
    }
    
    
    func cellClick(){
        
    }
    
    func storeBoardValues()->some View{
        
        DispatchQueue.main.async {
            nums.removeAll()
            cellNumb = cellNumbI
        }
        
        shouldUpdate = false
        return EmptyView()
    }
}

struct MainBoardView_Previews: PreviewProvider {
    static var previews: some View {
        MainBoardView()
    }
}
