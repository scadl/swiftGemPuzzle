//
//  MainBoardView.swift
//  MyFirstApp
//
//  Created by Admin on 10.10.2020.
//

import SwiftUI

var turn:Int = 0
var nums:[String] = []
var lastNum:String = ""

struct MainBoardView: View {
    
    var counter:[Int] = [1,2,3,4]
    let cellSize:CGFloat = 70.0
    
    var body: some View {

        VStack{
            Text("Turn: "+String(turn))
            
            ForEach(counter, id:\.self){ num in
                HStack {
                    ForEach(counter, id:\.self){ num in
                        
                        var num = getRandUniq()
                        var visNumber = num=="0" ? " " : num
                        var curColor:Color = num=="0" ? Color.gray : Color.blue
                        
                        Button(visNumber, action: {
                            if(curColor==Color.blue){
                                curColor = Color.purple
                            } else if (curColor==Color.purple){
                                curColor = Color.blue
                            }
                            print("num "+num)
                            if(lastNum==""){
                                lastNum = num
                            } else {
                                visNumber = lastNum
                                lastNum = ""
                            }
                            print("lastnum "+lastNum)
                       }).font(.title)
                            .frame(width: cellSize, height: cellSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(curColor)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                        
                    }
                }.padding(1)
            }
        
        }
        
    }
    
    func getRandUniq()->String{
        
        var cur = 0
        while((nums.firstIndex(of: String(cur))) != nil){
            cur = Int.random(in: 1...Int(pow(Double(counter.count),2))-1)
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
