//
//  MainBoardView.swift
//  MyFirstApp
//
//  Created by Admin on 10.10.2020.
//

import SwiftUI

var turn:Int = 0
var nums:[String] = []

struct MainBoardView: View {
    
    var counter:[Int] = [1,2,3,4]
    let cellSize:CGFloat = 70.0
    
    var body: some View {

        VStack{
            Text("Turn: "+String(turn))
            
            ForEach(counter, id:\.self){ num in
                HStack {
                    ForEach(counter, id:\.self){ num in
                        let num = getRandAndRemove()
                        if (num=="0"){
                            BoardCellView(
                                cellText: "",
                                cellSize: cellSize,
                                cellColor: Color.gray,
                                onTo: {
                                    print("zero"+num)
                                })
                        } else {
                            BoardCellView(
                                cellText: num,
                                cellSize: cellSize,
                                cellColor: Color.blue,
                                onTo: {
                                    print("number"+num)
                                })
                        }
                    }
                }.padding(2)
            }
        
        }
        
    }
    
    func getRandAndRemove()->String{
        
        var cur = 0
        while((nums.firstIndex(of: String(cur))) != nil){
            cur = Int.random(in: 1...counter.count*counter.count-1)
        }
        nums.append(String(cur))
        
        return String(cur)
    }
    
    func cellClick(){
        
    }
}

struct MainBoardView_Previews: PreviewProvider {
    static var previews: some View {
        MainBoardView()
    }
}
