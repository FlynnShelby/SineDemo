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
    
    //初始x偏移量
    var offsetX0:CGFloat = 0
    //相位差：参数p = w * offsetX0
    var p:CGFloat = 0
    
    //y偏移量，>0上移,<0下移
    var d: CGFloat = 0.0
    //周期数
    let num: CGFloat = 1
    
    
    //解sine函数公式得到y
    // x => y
    func solveSineFuncGetYWithX(_ x:CGFloat) -> CGFloat {
        return  a*sin(w*(x+offsetX)+p)+d
    }
  
    
    override func draw(_ rect: CGRect) {
       
        let O = CGPoint(x: 0, y: rect.height/2)
        
        let sinLine = UIBezierPath()
        sinLine.lineWidth = 2.0
        UIColor.orange.setStroke()
        
        for i in 0...100 {
            let m = rect.width/100.0
            let x = CGFloat(i)*m
            
            let y = solveSineFuncGetYWithX(CGFloat(x))
            
            let p = CGPoint(x: x, y: O.y-y)
            
            if i == 0 {
                sinLine.move(to: p)
            }else{
                sinLine.addLine(to: p)
            }
        }
        
        sinLine.stroke()
    }
    
    
}
