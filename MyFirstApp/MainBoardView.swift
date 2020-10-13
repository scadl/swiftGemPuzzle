//
//  MainBoardView.swift
//  MyFirstApp
//
//  Created by Admin on 10.10.2020.
//

import SwiftUI

var turn:Int = 0            // Player turns count
var nums:[String] = []      // Storage of used number
var cellNumb = [[String]]()

struct MainBoardView: View {
    
    var counter:[Int] = [1,2,3,4]           // Game board cells count
    let cellSize:CGFloat = 70.0             // Game baord cells size
    //@State var cellNumb = [[String]]()      // Dictioanry of cells values
    
    var body: some View {

        VStack{
            Text("Turn: "+String(turn))
            
            // Row building cycle
            ForEach(counter, id:\.self){ numRow in
                
                let _ = print("r:"+String(numRow))
                makeRow(row: numRow)
                
                HStack {
                    // Column building cycle
                    ForEach(counter, id:\.self){ numCol in
                        
                        let _ = print("c:"+String(numCol))
                        
                        let rVal = getRandAndRemove(row: numRow, col: numCol)
                        
                        let cVal = rVal
                        let curColor = cVal=="0" ? Color.gray : Color.blue
                        let curNum = cVal=="0" ? " " : cVal
                        BoardCellView(
                                cellText: curNum,
                                cellSize: cellSize,
                                cellColor: curColor,
                                onTo: {
                                    print("click ")
                                }
                        )
                        
                        let _ = print(cellNumb)
                    }
                }.padding(2)
            }
        
        }
        
    }
    
    // A function for generating non-repeating random numbers
    func getRandAndRemove(row:Int,col:Int)->String{
        
        var cur = 0
                            
        
        while((nums.firstIndex(of: String(cur))) != nil){
            cur = Int.random(in: 1...Int(pow(Double(counter.count),2))-1)
        }
        nums.append(String(cur))
        
        
        //if(cellNumb[row][col]==nil) {
        cellNumb[row-1].append(String(cur))
        //}

        return String(cur)
    }
    
    func makeRow(row:Int)->some View{
        cellNumb.append([])
        return EmptyView()
    }
    
    func cellClick(){
        
    }
}

struct MainBoardView_Previews: PreviewProvider {
    static var previews: some View {
        MainBoardView()
    }
}
