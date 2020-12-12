//
//  MainBoardView.swift
//  MyFirstApp
//
//  Created by scadl on 10.10.2020.
//

import SwiftUI

var turn:Int = 0                // Player turns count
var nums:[String] = []          // Storage of used number
var counter:[Int] = [0,1,2,3]           // Game board cells count and index
let cellSize:CGFloat = 70.0             // Game baord cells size
var lastNum = ""                         // Last clicked board cells value
var lastCoord = [Int](repeating: 0, count: 2)    // Coords of last clicked tile

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
    @State var shouldUpd = true                                 // UI AutoUpdate flag
    @State var showAlert = false                                // show alert flag
    @State var alertText = [String](repeating: "", count: 3)    //A storage for poupup text
    
    var body: some View {
        
        VStack{
            Text("Turn: "+String(turn)).foregroundColor(.blue).padding(3)
            VStack{
                
                
                // Row building cycle
                ForEach(counter, id:\.self){ numRow in
                    
                    HStack(alignment: .center, spacing: 0.0) {
                        // Column building cycle
                        ForEach(counter, id:\.self){ numCol in
                            
                            // Generate and store new random number
                            if(shouldUpd){
                                getRandAndRemove(row: numRow, col: numCol)
                            }
                            
                            BoardCellView(
                                cellText: cellNumb[numRow][numCol]=="0" ? " " : cellNumb[numRow][numCol],
                                cellSize: cellSize,
                                cellColor: setCellFill(Row: numRow, Col: numCol),
                                cellBorder: cellNumb[numRow][numCol]=="0"
                                    ? Color.init(white: 0, opacity: 0)
                                    : Color.blue
                            ).modifier(
                                dragBinder(
                                    label: cellNumb[numRow][numCol],
                                    actionCall: {cellClickProcessor(Row: numRow, Col: numCol)},
                                    Row: numRow, Col: numCol
                                )
                            )
                            
                        }
                    }.padding(0.0)
                    
                }
                
                // Allow to update the board
                if (shouldUpd){
                    storeBoardValues()
                }
                //let _ = print(cellNumbI)
                //let _ = print(cellNumb)
                
            }
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text(alertText[0]),
                    message: Text(alertText[1]),
                    dismissButton: .default(Text(alertText[2]))
                )
            }).overlay(Rectangle().stroke().fill(Color.blue))
        }
        
    }
    
    // Custom modifier for binding right mechanic
    struct dragBinder:ViewModifier {
        var label:String
        let actionCall:()->Void
        var Row:Int
        var Col:Int
        func body(content: Content) -> some View {
            // A conatainer allowing "returning [NOT] multiple views"
            VStack{
                // Create drop zone only at empty cell
                if(label=="0"){
                    content.onDrop(of: ["public.text"], delegate: dropProc(binderCall: actionCall))
                } else {
                    if(
                        (lastCoord[0]==Row-1 && lastCoord[1]==Col) ||
                            (lastCoord[0]==Row+1 && lastCoord[1]==Col) ||
                            (lastCoord[0]==Row && lastCoord[1]==Col-1) ||
                            (lastCoord[0]==Row && lastCoord[1]==Col+1)
                    ){
                        content.onDrag{
                            actionCall()
                            return NSItemProvider(object: label as NSString)
                        }
                    } else{
                        content
                    }
                }
            }
        }
    }
    
    // DropZone processor
    struct dropProc: DropDelegate {
        let binderCall:()->Void
        
        func validateDrop(info: DropInfo) -> Bool {
            return info.hasItemsConforming(to: ["public.text"])
        }
        
        func dropEntered(info: DropInfo) {
            //NSSound(named: "Morse")?.play()
        }
        
        func performDrop(info: DropInfo) -> Bool {
            info.itemProviders(for: ["public.text"])[0].loadObject(ofClass: String.self){ str,_ in
                DispatchQueue.main.async {
                    binderCall()
                    //print(str!)
                }
            }
            return true
        }
        
    }
    
    // Generating non-repeating random numbers
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
    func cellClickVisual(newVal:String,oldCoord:[Int],row:Int,col:Int){
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
    
    // Click event process and check
    func cellClickProcessor(Row:Int,Col:Int){
        
        //print("cCP call "+String(Row)+" "+String(Col))
        
        if (lastNum==""){
            // Remember value of first click
            lastNum = cellNumb[Row][Col]
            lastCoord = [Row, Col]
            
        } else {
            if(
                cellNumb[Row][Col]=="0" 
            ){
                // Write value of first clik to second
                cellClickVisual(
                    newVal: lastNum, oldCoord: lastCoord,
                    row: Row, col: Col)
            } else {
                // This tiles are not exchangable - reset last click
                lastNum = ""
                print("worng move")
            }
        }
    }
    
    // Fill game board with generated data
    func storeBoardValues()->some View{
        
        DispatchQueue.main.async {
            nums.removeAll()
            lastNum = ""
            lastCoord = [0,0]
            turn = 0
            cellNumb = cellNumbI
            shouldUpd = false
        }
        
        return EmptyView()
    }
    
    // Provide a correct fil for the cell (callback type)
    func setCellFill(Row:Int,Col:Int)->Image{
        if(cellNumb[Row][Col]=="0"){
            return Image("cellBgE")
        }else{
            return Image("cellBg")
        }
    }
}

struct MainBoardView_Previews: PreviewProvider {
    static var previews: some View {
        MainBoardView()
    }
}
