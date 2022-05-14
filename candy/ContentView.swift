//
//  ContentView.swift
//  candy
//
//  Created by 賴冠宏 on 2022/5/5.
//

import SwiftUI

struct Data: Identifiable{
    let id = UUID()
    var name: Int
    var rotateDegree: Double = 0
}

struct ContentView: View {
    @State private var candy = [Data]()
    
    //@State var albums = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]
    //@State var imgg = ["1", "2", "3", "4"]
    @State private var offset = CGSize.zero
    @State private var startDetectDrag = false
    @State private var number = 1
    @State private var temp = 1
    @State private var mod = 0
    @State private var isChange = 0
    @State private var score = 0
    @State private var show = false
    //@State private var rotateDegree: Double = 0
    @State private var startT:Double=60.0
    //@State private var arrs: [[arr]] = Array(repeating: Array(repeating: Donut(),count: 5),count: 5)
    
    func initial(){
        candy.removeAll()
        for _ in 1...25{
            candy.append(Data(name: Int.random(in: 1..<8)))
        }
        canDo()
        //rotateDegree = 180
    }
    //
    func up(index: Int){
        temp = candy[index].name
        if(index-5 >= 0){
            candy[index].name = candy[index-5].name
            candy[index-5].name = temp
        }
    }
    func down(index: Int){
        temp = candy[index].name
        if(index+5 < 25){
            candy[index].name = candy[index+5].name
            candy[index+5].name = temp
        }
    }
    func left(index: Int){
        temp = candy[index].name
        if(index%5 != 0){
            candy[index].name = candy[index-1].name
            candy[index-1].name = temp
        }
    }
    func right(index: Int){
        temp = candy[index].name
        if(index%5 != 4){
            candy[index].name = candy[index+1].name
            candy[index+1].name = temp
        }
    }
    //
    func randomNew(site: Int){
            //candy[site].rotateDegree = 0
        //withAnimation(.easeInOut(duration:0.3)){
//        for i in 0...24{
//            candy[i].rotateDegree = 0
//        }
        candy[site].name = Int.random(in: 1..<8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            candy[site].rotateDegree = 360
        }
        candy[site].rotateDegree = 0
        
        //}
    }
    //
    func canDo(){
        var sameC = 0
        var sameC2 = 0
        var num = 0
        isChange = 0
//        for v in 0...24{
//            candy[v].rotateDegree = 0
//        }
        //直的
        for i in 0...24{
            sameC = 0
            num = i + 5
            while(num<25){
                if(candy[i].name==candy[num].name && candy[num].name==candy[num-5].name){
                    num = num + 5
                    sameC += 1
                    print("as-\(sameC)")
                }
                else{
                    break
                }
            }
            if(sameC==2){
                isChange = 1
                score += 10
                randomNew(site: i)
                randomNew(site: i+5)
                randomNew(site: i+10)
            }
            if(sameC==3){
                isChange = 1
                score += 20
                randomNew(site: i)
                randomNew(site: i+5)
                randomNew(site: i+10)
                randomNew(site: i+15)
            }
            if(sameC==4){
                isChange = 1
                score += 30
                randomNew(site: i)
                randomNew(site: i+5)
                randomNew(site: i+10)
                randomNew(site: i+15)
                randomNew(site: i+20)
            }
        }
        //橫的
        for j in 0...23{
            sameC2 = 0
            num = j + 1
            if(j%5 < 3){
                while(num%5<=4 && num<25){
                    if(candy[j].name==candy[num].name && candy[num].name==candy[num-1].name){
                        num = num + 1
                        sameC2 += 1
                        print("asr-\(sameC2)")
                    }
                    else{
                        break
                    }
                }
                if(sameC2==2){
                    isChange = 1
                    score += 10
                    randomNew(site: j)
                    randomNew(site: j+1)
                    randomNew(site: j+2)
                }
                if(sameC2==3){
                    isChange = 1
                    score += 20
                    randomNew(site: j)
                    randomNew(site: j+1)
                    randomNew(site: j+2)
                    randomNew(site: j+3)
                }
                if(sameC2==4){
                    isChange = 1
                    score += 30
                    randomNew(site: j)
                    randomNew(site: j+1)
                    randomNew(site: j+2)
                    randomNew(site: j+3)
                    randomNew(site: j+4)
                }
            }
        }
    }
    
    func dragGesture(index: Int) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged({ value in
                if startDetectDrag {
                    print("\(index)")
                    if value.translation.width > 20 {
                        //number += 1
                        //var temp = albums[imgg]
                        //albums[imgg] = albums[imgg+1]
                        //albums[imgg+1] = temp
                        right(index: index)
                        mod = 4
                        startDetectDrag = false
                    }
                    else if value.translation.width < -20 {
                        left(index: index)
                        mod = 3
                        startDetectDrag = false
                    }
                    else if value.translation.height > 20 {
                        down(index: index)
                        mod = 2
                        startDetectDrag = false
                    }
                    else if value.translation.height < -20 {
                        up(index: index)
                        mod = 1
                        startDetectDrag = false
                    }
                }
                else {
                    if value.translation == .zero {
                        startDetectDrag = true
                    }
                }
            })
            .onEnded { value in
                canDo()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//                    rotateDegree = 260
//                }
                print("\(isChange)")
                if(isChange == 0){
                    if(mod == 1){
                        up(index: index)
                        startDetectDrag = false
                    }
                    else if(mod == 2){
                        down(index: index)
                        startDetectDrag = false
                    }
                    else if(mod == 3){
                        left(index: index)
                        startDetectDrag = false
                    }
                    else if(mod == 4){
                        right(index: index)
                        startDetectDrag = false
                    }
                }
                //canDo()
//                for i in 0...24{
//                    candy[i].rotateDegree = 0
//                }
//                else{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//                        rotateDegree = 270
//                    }
                
                
            }
                
            
    }
    var body: some View {

        VStack{
            Text("score:\(score)")
            Button("start"){
                initial()
                canDo()
                score = 0
            }
            VStack(spacing:0){
                Text("剩餘時間: \(String(format: "%.1f", startT))")
                    .onAppear{
                        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ t in
                            startT -= 0.1
                            if startT < 0.1{
                                startT=0
                                //initial()
                                //highScore = max(highScore,score)
                                //t.invalidate()
                            }
                        }
                    }
                    Rectangle()
                        .fill(Color.green)
                        .frame(width:CGFloat(Double(UIScreen.main.bounds.width)*startT/60.0), height:10)
            }
            //let columns = [GridItem(), GridItem()]
            VStack{
               
            let columns = Array(repeating: GridItem(), count: 5)
            LazyVGrid(columns: columns) {
                ForEach(Array(candy.enumerated()), id: \.element.id) { index, data in
                    Rectangle()
                        .fill(Color.blue)
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            Image("\(data.name)")
                                .resizable()
                                .rotationEffect(.degrees(candy[index].rotateDegree))
                                .animation(
                                   Animation.linear(duration: 2)
                                      .repeatCount(1, autoreverses: false),
                                    value: candy[index].rotateDegree
                                )
                                .gesture(dragGesture(index: index))
                        )
                    
                    }
                }
                Button("random"){
                    initial()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        for i in 0...24{
                            candy[i].rotateDegree = 360
                        }
                    }
                    for i in 0...24{
                        candy[i].rotateDegree = 0
                    }
                    //
                }
            }
            
        }
            
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
