//
//  ViewController.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/5/1.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    @IBOutlet var batter9: UILabel!
    @IBOutlet var batter8: UILabel!
    @IBOutlet var batter7: UILabel!
    @IBOutlet var batter6: UILabel!
    @IBOutlet var batter5: UILabel!
    @IBOutlet var batter4: UILabel!
    @IBOutlet var batter3: UILabel!
    @IBOutlet var batter2: UILabel!
    @IBOutlet var batter1: UILabel!
    var batters = [UILabel]()
    var batterOn = -1
    var out = 0
    let base1X = 344.0
    let base1Y = 180.0
    let base2X = 249
    let base2Y = 104
    let base3X = 155
    let base3Y = 180
    let base0X = 226
    let base0Y = 260
    let base4X = 249
    let base4Y = 260
    
    func runner(batter: Int){
        for i in 0 ... 8 {
            if i == batterOn {
                continue
            }
            if self.batters[i].center.x == 344 &&
                self.batters[i].center.y == 180 {
                UIView.animate(withDuration: 1.0, animations: {
                self.batters[i].center.x = 249
                self.batters[i].center.y = 104
                })
            }
            else if self.batters[i].center.x == 249 &&
                self.batters[i].center.y == 104 {
                UIView.animate(withDuration: 1.0, animations: {
                    self.batters[i].center.x = 155
                    self.batters[i].center.y = 180
                })
            }
            else if self.batters[i].center.x == 155 &&
                self.batters[i].center.y == 180 {
                UIView.animate(withDuration: 1.0, animations: {
                    self.batters[i].center.x = 249
                    self.batters[i].center.y = 260
                })
                UIView.animate(withDuration: 1.0,delay: 2.0,animations: {
                    self.batters[i].alpha = 0.0
                    self.batters[i].center.x = 100
                    self.batters[i].center.y = 250
                })
            }
        }
    }
    
    @IBAction func callNextBatter(sender: AnyObject){
        UIView.animate(withDuration: 1.0,animations: {
            self.batterOn = self.batterOn + 1
            if self.batterOn == 9{
                self.batterOn = 0
            }
            self.batters[self.batterOn].alpha = 1.0
            self.batters[self.batterOn].center.x = 226
            self.batters[self.batterOn].center.y = 260
        })
    }

    @IBAction func batterOut(sender: AnyObject){
        UIView.animate(withDuration: 1.0,animations: {
            self.batters[self.batterOn].alpha = 0.0
            self.batters[self.batterOn].center.x = 100
            self.batters[self.batterOn].center.y = 250
            self.out = self.out + 1
        })
    }

    @IBAction func toNextBase(sender: AnyObject) {
        //0to1
        UIView.animate(withDuration: 1.0,animations: {
            self.batters[self.batterOn].center.x = 344
            self.batters[self.batterOn].center.y = 180
            self.runner(batter: self.batterOn)
        })
        /*
        //3to4
        UIView.animate(withDuration: 0.5,animations: {
            self.runner3.center.x = 249
            self.runner3.center.y = 260
            
        })
        UIView.animate(withDuration: 0.5,delay: 1.0,animations: {
            self.runner3.center.x = 131
            self.runner3.center.y = 180
        })
       //2to3
        UIView.animate(withDuration: 0.5,animations: {
            self.runner2.center.x = 155
            self.runner2.center.y = 180

        })
        UIView.animate(withDuration: 0.5,delay: 1.0,animations: {
            self.runner2.center.x = 232
            self.runner2.center.y = 104
        })
        //1to2
        UIView.animate(withDuration: 0.5,animations: {
            self.runner1.center.x = 249
            self.runner1.center.y = 104
            
        })
        UIView.animate(withDuration: 0.5,delay: 1.0,animations: {
            self.runner1.center.x = 344
            self.runner1.center.y = 180
        })
        */

        
    }

    /*
    @IBOutlet var oneTapForSrike: UITapGestureRecognizer!

    @IBAction func hit(_ sender: Any) {
        
    }
    @IBOutlet weak var hitResult: UIView!
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
 
    @IBAction func buttonClicked(sender: AnyObject) {
    }
 */
    override func viewDidLoad() {
        super.viewDidLoad()
        batters = [batter1,batter2,batter3,batter4,batter5,batter6,batter7,batter8,batter9]
        /*
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["FO","AO","1B","2B","3B","HR","FC","SF","SH","DP","TP"]
        // Do any additional setup after loading the view, typically from a nib.
 */
 }
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
 */

}
