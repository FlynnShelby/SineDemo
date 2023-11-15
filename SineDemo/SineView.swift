//
//  SineView.swift
//  SineDemo
//
//  Created by XieLinFu_Mac on 2023/11/14.
//

import UIKit

class SineView: UIView {
    
    //振幅
    var a: CGFloat = 0.0
    //周期T
    var T: CGFloat = 200.0
    
    //角频率：波长缩放倍率 w = 2π / T
    var w:CGFloat = 0.0314
    
    //x偏移量，<0右移，>0左移
    var offsetX: CGFloat = 0
    
    //x偏移量，<0右移，>0左移
    var offsetX0:CGFloat = 0
    //（初相位差）相位差：参数p
    var p:CGFloat = 0
    
    //y偏移量，>0上移,<0下移
    var d: CGFloat = 0.0
    //周期数
    var num: CGFloat = 5
    
    var startX = 0
    
    var endX = 380
    
    //解sine函数公式得到y
    // x => y
    func solveSineFuncGetYWithX(_ x:CGFloat) -> CGFloat {
        return  a*sin(w*(x+offsetX0)+p)+d
    }
  
    
    override func draw(_ rect: CGRect) {
       
//        drawSineLine()
        
        drawSineLine0()
    }
    
    //物理平移方式绘制曲线（先确定函数，再平移）
    func drawSineLine(){
        let O = CGPoint(x: 0, y: frame.height/2)
        
        let sinLine = UIBezierPath()
        sinLine.lineWidth = 2.0
        UIColor.orange.setStroke()
        
        startX = Int(offsetX)
        endX = Int(T*num)
         
        //sine曲线以0为起点，画线时平移曲线，使用offsetX
        for x in 0...Int(T*num) {
            
            let y = solveSineFuncGetYWithX(CGFloat(x))
            
            let p = CGPoint(x: offsetX+CGFloat(x), y: O.y-y)
            
            if x == 0 {
                sinLine.move(to: p)
            }else{
                sinLine.addLine(to: p)
            }
        }
        
        sinLine.stroke()
    }
    
    //函数平移方式绘制曲线(平移量作为函数参数)
    func drawSineLine0(){
        let O = CGPoint(x: 0, y: frame.height/2)
        
        let sinLine = UIBezierPath()
        sinLine.lineWidth = 2.0
        UIColor.orange.setStroke()
          
        startX = Int(-offsetX0)
        endX = startX + Int(num * T)
        //画线之前sine函数平移，使用offsetX0
        for x in startX...endX {
            let y = solveSineFuncGetYWithX(CGFloat(x))
            
            let p = CGPoint(x: CGFloat(x), y: O.y-y)
            
            if x == startX {
                sinLine.move(to: p)
            }else{
                sinLine.addLine(to: p)
            }
        }
        
        sinLine.stroke()
    }
}
