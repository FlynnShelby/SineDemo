//
//  ViewController.swift
//  SineDemo
//
//  Created by XieLinFu_Mac on 2023/11/14.
//

import UIKit

var KScreenWidth = UIScreen.main.bounds.width
var KScreenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController {
    
    var lab = UILabel()
    
    var aBtn = UIButton()
    
    var wBtn = UIButton()
    
    var TBtn = UIButton()
    
    var offsetXBtn = UIButton()
    
    var pBtn = UIButton()
    
    var offsetX0Btn = UIButton()
    
    var dBtn = UIButton()
    
    var TNumBtn = UIButton()
    
    var index = 0
    
    var sineV = SineView()
    
    var slider = UISlider()
    
    
    var btnArr = [UIButton]()
    let titleArr = ["a:","w:","T:",
                    "offsetX:","p:","offsetX0:","d:","TNum:"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        
        updateUI()
    }

    
    func setupUI()  {
        
        lab.frame = CGRectMake(0, 0, KScreenWidth-20, 60)
        lab.center = CGPoint(x: KScreenWidth/2, y: 80)
        lab.layer.borderColor = UIColor.orange.cgColor
        lab.layer.borderWidth = 1.0
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textColor = .red
        lab.textAlignment = .center
        lab.numberOfLines = 0
        view.addSubview(lab)
        
        btnArr = [aBtn,wBtn,TBtn,offsetXBtn,pBtn,offsetX0Btn,dBtn,TNumBtn]
        
       
        for i in 0..<btnArr.count {
            let btn = btnArr[i];
            btn.frame = CGRectMake(0, 0, 150, 40)
            
            btn.center = CGPoint(x:Int(KScreenWidth)*((i%2*2)+1)/4 , y: (i/2)*60+150)
            btn.layer.borderColor = UIColor.green.cgColor
            btn.layer.borderWidth = 1.0
            
            btn.setTitle(titleArr[i], for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.setTitleColor(.red, for: .selected)
            
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(paramsBtnClicked(_:)), for: .touchUpInside)
            
            
            view.addSubview(btn)
        }
        
        
        sineV.frame = CGRectMake((KScreenWidth-380)/2, 380, 380, 400)
        sineV.backgroundColor = .cyan
        view.addSubview(sineV)
          
        
        slider.frame = CGRectMake(20, KScreenHeight-80, KScreenWidth-40, 40)
        slider.minimumValue = -200.0
        slider.maximumValue = 200.0
        slider.value = Float(sineV.a)
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
    }

    @objc func paramsBtnClicked(_ sender:UIButton) {
        btnArr.forEach { btn in
            btn.isSelected = false
        }
        sender.isSelected = true
        index = sender.tag - 1000
        
        switch index {
        case 0://a
            
            slider.minimumValue = -200.0
            slider.maximumValue = 200.0
            slider.value = Float(sineV.a)
            
            break
        case 1://w
            slider.minimumValue = 2*Float.pi/380.0
            slider.maximumValue = 1
            slider.value = Float(sineV.w)
            break
        case 2://T
            slider.minimumValue = 2*Float.pi
            slider.maximumValue = 380.0
            slider.value = Float(sineV.T)
            break
        case 3://offsetX
            slider.minimumValue = 0
            slider.maximumValue = 380.0
            slider.value = Float(sineV.offsetX)
            break
        case 4://p
            slider.minimumValue = -2*Float.pi
            slider.maximumValue = 2*Float.pi
            slider.value = Float(sineV.p)
            break
        case 5://offsetX0
            slider.minimumValue = 0
            slider.maximumValue = 380.0
            slider.value = Float(sineV.offsetX0)
            break
        case 6://d
            slider.minimumValue = -190.0
            slider.maximumValue = 190.0
            slider.value = Float(sineV.d)
            break
        case 7://num
            slider.minimumValue = 0.0
            slider.maximumValue = 5.0
            slider.value = Float(sineV.num)
            break
        default:
            break
        }
    }
    
     
    @objc func sliderValueChanged(_ slider:UISlider){
        
        let value = CGFloat(slider.value).roundedReserve(n: 2)
        switch index {
        case 0://a
            sineV.a = value
             
            break
        case 1://w
            let w = CGFloat(slider.value).roundedReserve(n: 4)
            sineV.w = w
            
            let t = 2*CGFloat.pi/w
            sineV.T = t.roundedReserve(n: 2)
            
            break
        case 2://T
            sineV.T = value
            
            let w = 2*CGFloat.pi/value
            sineV.w = w.roundedReserve(n: 4)
            
            break
        case 3://offsetX
            sineV.offsetX = value
            
            break
        case 4://p
            sineV.p = value
            
            break
        case 5://offsetX0
            sineV.offsetX0 = value
            
            
            break
        case 6://d
            sineV.d = value
            
            break
        case 7://num
            sineV.num = value
            
            break
        default:
            break
        }
        
       
        updateUI()
        
    }
    
    func updateUI(){
        
        let valueArr = [sineV.a,sineV.w,sineV.T,sineV.offsetX,sineV.p,sineV.offsetX0,sineV.d,sineV.num]
        for i in 0..<btnArr.count {
            let value = valueArr[i]
            var title = String(format: "%@ %.2f", titleArr[i],value)
            if i == 1 {
                title = String(format: "%@ %.4f", titleArr[i],value)
            }
            btnArr[i].setTitle(title, for: .normal)
        }
        
        lab.text = "y = \(sineV.a)sin(\(sineV.w) * (x + \(sineV.offsetX)) + \(sineV.p)) + \(sineV.d)"
        
        sineV.setNeedsDisplay()
    }
}


extension CGFloat {
    func roundedReserve(n:Int) -> CGFloat{
        
        let rate = CGFloat(pow(10.0, Double(n)))
        return  ((self*rate).rounded()/rate)
    }
}
