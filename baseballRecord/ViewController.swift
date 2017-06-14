//
//  ViewController.swift
//  baseballRecord
//
//  Created by 賴昱榮 on 2017/5/1.
//  Copyright © 2017年 賴昱榮. All rights reserved.
//

import UIKit

class Player{
    var name = ""
    var atBat = 0 //打擊次數
    var hit = 0 //安打數
    var ip:Float = 0.0 //投球局數
    var position = "" //守備位置
    var ER:Float = 0 //自責分
    var pitchH = 0 //被安打數
    init(as name: String ,position pos: String) {
        self.name = name
        self.position = pos
    }
    //設定打者名字
    func setName(as name: String){
        self.name = name
    }
    //取得打者名字
    func getName() -> String {
        return self.name
    }
    //增加打者安打數
    func addHit(){
        self.hit += 1
        self.atBat += 1
    }
    //增加打者出局數
    func addOut(){
        self.atBat += 1
    }
    //增加被安打數
    func addPitchH(){
        self.pitchH += 1
    }
    //增加投球局數
    func addIP(){
        self.ip += 0.1
    }
    //增加自責失分
    func addER(){
        self.ER += 1
    }
    //取得安打數
    func getHit() ->String{
        return String(self.hit)
    }
    //取得打擊數
    func getAtBat() -> String{
        return String(self.atBat)
    }
    //取得打擊率
    func getBA() -> String{
        var BA:Float
        if self.atBat == 0{
            BA = 0.000
        }else{
            BA = Float(self.hit / self.atBat)
        }
        return String(format:"%.3f", BA )
    }
    //取得守備位置
    func getPosition() -> String{
        return self.position
    }
    //取得投手被打擊數
    func getPitchH() -> String{
            return String(self.pitchH)
    }
    //取得投球局數
    func getPitchIP() -> String{
        return String(self.ip)
    }
    //取得防禦率
    func getERA() -> String{
        var ERA:Float
        if self.ER == 0{
            ERA = 0.000
        }else if self.ER > 0 && self.ip == 0{
            ERA = 999.999
        }
        else{
            ERA = Float((self.ER * 9) / self.ip)
        }
        print(self.ER )
        print(self.ER * 9)
        print(self.ip)
        print((self.ER * 9) / self.ip)
        print(String((self.ER * 9) / self.ip))
        return String(format:"%.3f", ERA)
    }
}

class ViewController: UIViewController{
    var players = [String: Player]()
    var playerClassList = [Player]()
    
    
    @IBOutlet var awayPlayer9: UILabel!
    @IBOutlet var awayPlayer8: UILabel!
    @IBOutlet var awayPlayer7: UILabel!
    @IBOutlet var awayPlayer6: UILabel!
    @IBOutlet var awayPlayer5: UILabel!
    @IBOutlet var awayPlayer4: UILabel!
    @IBOutlet var awayPlayer3: UILabel!
    @IBOutlet var awayPlayer2: UILabel!
    @IBOutlet var awayPlayer1: UILabel!
    
    @IBOutlet var homePlayer9: UILabel!
    @IBOutlet var homePlayer8: UILabel!
    @IBOutlet var homePlayer7: UILabel!
    @IBOutlet var homePlayer6: UILabel!
    @IBOutlet var homePlayer5: UILabel!
    @IBOutlet var homePlayer4: UILabel!
    @IBOutlet var homePlayer3: UILabel!
    @IBOutlet var homePlayer2: UILabel!
    @IBOutlet var homePlayer1: UILabel!
/*
    @IBOutlet var top1: UILabel!
    @IBOutlet var bottom1: UILabel!
    @IBOutlet var top2: UILabel!
    @IBOutlet var bottom2: UILabel!
    @IBOutlet var top3: UILabel!
    @IBOutlet var bottom3: UILabel!
    @IBOutlet var top4: UILabel!
    @IBOutlet var bottom4: UILabel!
    @IBOutlet var top5: UILabel!
    @IBOutlet var bottom5: UILabel!
    @IBOutlet var top6: UILabel!
    @IBOutlet var bottom6: UILabel!
    @IBOutlet var top7: UILabel!
    @IBOutlet var bottom7: UILabel!
    @IBOutlet var top8: UILabel!
    @IBOutlet var bottom8: UILabel!
    @IBOutlet var top9: UILabel!
    @IBOutlet var bottom9: UILabel!
*/
    //print("player")
    @IBOutlet var outCount: UILabel!
    @IBOutlet var innings: UILabel!
    @IBOutlet var awayScore: UILabel!
    @IBOutlet var homeScore: UILabel!
    @IBOutlet var awayHit: UILabel!
    @IBOutlet var homeHit: UILabel!
    @IBOutlet var playerHit: UILabel! //上場打者打擊紀錄
    @IBOutlet var playerName: UILabel! //上場打者名字
    @IBOutlet var playerBA: UILabel! //上場打者打擊率
    @IBOutlet var playerPosition: UILabel! //上場打者守備位置
    @IBOutlet var pitchName: UILabel! //投手名字
    @IBOutlet var pitchIP: UILabel! //投球局數
    @IBOutlet var pitchERA: UILabel! //投手防禦率
    @IBOutlet var pitchH: UILabel! //投手被安打數
    


//    @IBOutlet var dynamicPlayer: Player!
    var batters = [[UILabel]]()
    var inningScore = [[UILabel]]()
    var batterOn = [-1 , -1]
    var out = 0
    var inning = 1
    var awayHits = 0
    var homeHits = 0
    var awayScoring = 0
    var homeScoring = 0
    var awayOrHome = 0
    var thisInningScore = 0
    
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
    
    func setDefence(){
        var whichTeamDefence = 1
        UIView.animate(withDuration: 1.0, delay: 1.0, animations: {
            if self.awayOrHome == 1 {
                whichTeamDefence = 0
                for i in 0 ... 8 {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    self.batters[self.awayOrHome][i].center.x = 360
                    self.batters[self.awayOrHome][i].center.y = 250
                }
            }
            else{
                for i in 0 ... 8 {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    self.batters[self.awayOrHome][i].center.x = 100
                    self.batters[self.awayOrHome][i].center.y = 250
                }
            }
        })
        UIView.animate(withDuration: 1.0, delay: 2.0, animations: {
            for i in 0 ... 8{
                self.batters[whichTeamDefence][i].alpha = 1.0
            }
            self.batters[whichTeamDefence][0].center.x = 242
            self.batters[whichTeamDefence][0].center.y = 171
            self.batters[whichTeamDefence][1].center.x = 242
            self.batters[whichTeamDefence][1].center.y = 288
            self.batters[whichTeamDefence][2].center.x = 344
            self.batters[whichTeamDefence][2].center.y = 154
            self.batters[whichTeamDefence][3].center.x = 294
            self.batters[whichTeamDefence][3].center.y = 111
            self.batters[whichTeamDefence][4].center.x = 144
            self.batters[whichTeamDefence][4].center.y = 154
            self.batters[whichTeamDefence][5].center.x = 197
            self.batters[whichTeamDefence][5].center.y = 111
            self.batters[whichTeamDefence][6].center.x = 369
            self.batters[whichTeamDefence][6].center.y = 84
            self.batters[whichTeamDefence][7].center.x = 242
            self.batters[whichTeamDefence][7].center.y = 53
            self.batters[whichTeamDefence][8].center.x = 119
            self.batters[whichTeamDefence][8].center.y = 84
    })
        //投手資訊
        pitchName.text? = (players[self.batters[whichTeamDefence][0].text!]?.getName())!
        pitchIP.text? = (players[self.batters[whichTeamDefence][0].text!]?.getPitchIP())!
        pitchERA.text? = (players[self.batters[whichTeamDefence][0].text!]?.getERA())!
        pitchH.text? = (players[self.batters[whichTeamDefence][0].text!]?.getPitchH())!
        
    }
    
    func hitCheck(whichTeam: Int) {
        if whichTeam == 0 {
            awayHits = awayHits + 1
            awayHit.text = String (awayHits)
        }
        else{
            homeHits = homeHits + 1
            homeHit.text = String (homeHits)
        }
    }
    func inningCheck(whichTeam: Int) {
        if whichTeam == 0 {
            innings.text = String (inning) + "▼"
            awayOrHome = 1
        }
        else{
            inning = inning + 1
            innings.text = String (inning) + "▲"
            awayOrHome = 0
        }
        setDefence()
    }
    
    func scoring(whichTeam: Int) {
        if whichTeam == 0 {
            awayScoring = awayScoring + 1
            awayScore.text = String (awayScoring)
        }
        else{
            homeScoring = homeScoring + 1
            homeScore.text = String (homeScoring)
        }
        // 投手增加自責失分
        if awayOrHome == 1{
            players[self.batters[0][0].text!]?.addER()
            pitchERA.text? = (players[self.batters[0][0].text!]?.getERA())!
            
        }else{
            players[self.batters[1][0].text!]?.addER()
            pitchERA.text? = (players[self.batters[1][0].text!]?.getERA())!
        }
    }
    
    func setPlayerName (label: UILabel, name: String  ){
        label.text? = "●\n\(name)"
    }
    
    func runner(batter: Int, bases: Int){
        for j in 1 ... bases {
        for i in 0 ... 8 {
            if self.batters[awayOrHome][i].center.x == 226 &&
                self.batters[awayOrHome][i].center.y == 260{
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = 344
                    self.batters[self.awayOrHome][i].center.y = 180
                })

            }
                
            else if self.batters[awayOrHome][i].center.x == 344 &&
                self.batters[awayOrHome][i].center.y == 180 {
                UIView.animate(withDuration: 1.0, delay: TimeInterval(j-1),animations: {
                    self.batters[self.awayOrHome][i].center.x = 249
                    self.batters[self.awayOrHome][i].center.y = 104
                })
            }
            else if self.batters[awayOrHome][i].center.x == 249 &&
                self.batters[awayOrHome][i].center.y == 104 {
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = 155
                    self.batters[self.awayOrHome][i].center.y = 180
                })
            }
            else if self.batters[awayOrHome][i].center.x == 155 &&
                self.batters[awayOrHome][i].center.y == 180 {
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j-1), animations: {
                    self.batters[self.awayOrHome][i].center.x = 249
                    self.batters[self.awayOrHome][i].center.y = 260
                })
                UIView.animate(withDuration: 1.0,delay: TimeInterval(j) ,animations: {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    if self.awayOrHome == 0{
                        self.batters[self.awayOrHome][i].center.x = 100
                    }
                    if self.awayOrHome == 1{
                        self.batters[self.awayOrHome][i].center.x = 360
                    }
                    self.batters[self.awayOrHome][i].center.y = 250
                })
                scoring(whichTeam: awayOrHome)
                }
            }
        }
    }
    func outChecking(Count: Int){
        if Count % 3 == 2 {
            outCount.text = "● ●"
        }
        else if Count%3 == 1 {
            outCount.text = "● ○"
        }
        else if Count%3 == 0 {
            outCount.text = "○ ○"
        }
        if Count >= 3 {
            for i in 0 ... 8 {
             if self.batters[awayOrHome][i].center.x != 100 &&
                self.batters[awayOrHome][i].center.y != 250{
                UIView.animate(withDuration: 1.0,animations: {
                    self.batters[self.awayOrHome][i].alpha = 0.0
                    self.batters[self.awayOrHome][i].center.x = 100
                    self.batters[self.awayOrHome][i].center.y = 250
                })
            }
        }
            out = 0
            inningCheck(whichTeam: awayOrHome)
        }
    }
    @IBAction func callNextBatter(sender: AnyObject){
        self.batterOn[self.awayOrHome] = self.batterOn[self.awayOrHome] + 1
        if self.batterOn[self.awayOrHome] == 9{
            self.batterOn[self.awayOrHome] = 0
        }
        UIView.animate(withDuration: 1.0,animations: {
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].alpha = 1.0
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = 226
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = 260
         })
//        打者資訊
        playerName.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getName())!
        playerPosition.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getPosition())!
        playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
        playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
    }

    @IBAction func batterOut(sender: AnyObject){
        
        players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.addOut()
        //        打者打擊率
        playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
        //        打者打擊紀錄
        playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
        //        投手紀錄
        if awayOrHome == 1{
            players[self.batters[0][0].text!]?.addIP()
            pitchIP.text? = (players[self.batters[0][0].text!]?.getPitchIP())!
            pitchERA.text? = (players[self.batters[0][0].text!]?.getERA())!
        }else{
            players[self.batters[1][0].text!]?.addIP()
            pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
            pitchERA.text? = (players[self.batters[1][0].text!]?.getERA())!
        }
        
        UIView.animate(withDuration: 1.0,animations: {
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].alpha = 0.0
            if self.awayOrHome == 0 {
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = 100
            }
            else{
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.x = 360
            }
            self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].center.y = 250
            self.out = self.out + 1
            self.outChecking(Count: self.out)
        })
    }

    @IBAction func takeOneBase(sender: AnyObject) {
        //0to1
        
        players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.addHit()
        //        打者打擊率
        playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
        //        打者打擊紀錄
        playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
        //        投手紀錄
        if awayOrHome == 1{
            
            players[self.batters[0][0].text!]?.addPitchH()
            pitchIP.text? = (players[self.batters[0][0].text!]?.getPitchIP())!
            pitchH.text? = (players[self.batters[0][0].text!]?.getPitchH())!
        }else{
             
            players[self.batters[1][0].text!]?.addPitchH()
            pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
            pitchH.text? = (players[self.batters[1][0].text!]?.getPitchH())!
        }
        
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 1)
        self.hitCheck(whichTeam: self.awayOrHome)
        
    }
    @IBAction func takeTwoBase( sender: AnyObject) {
        
        players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.addHit()
        //        打者打擊率
        playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
        //        打者打擊紀錄
        playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
        //        投手紀錄
        if awayOrHome == 1{
            
            players[self.batters[0][0].text!]?.addPitchH()
            pitchIP.text? = (players[self.batters[0][0].text!]?.getPitchIP())!
            pitchH.text? = (players[self.batters[0][0].text!]?.getPitchH())!
        }else{
             
            players[self.batters[1][0].text!]?.addPitchH()
            pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
            pitchH.text? = (players[self.batters[1][0].text!]?.getPitchH())!
        }
        
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 2)
        self.hitCheck(whichTeam: self.awayOrHome)
    }
    @IBAction func takeThreeBase( sender: AnyObject) {
        players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.addHit()
        //        打者打擊率
        playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
        //        打者打擊紀錄
        playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
        //        投手紀錄
        if awayOrHome == 1{
             
            players[self.batters[0][0].text!]?.addPitchH()
            pitchIP.text? = (players[self.batters[0][0].text!]?.getPitchIP())!
            pitchH.text? = (players[self.batters[0][0].text!]?.getPitchH())!
        }else{
             
            players[self.batters[1][0].text!]?.addPitchH()
            pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
            pitchH.text? = (players[self.batters[1][0].text!]?.getPitchH())!
        }
        
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 3)
        self.hitCheck(whichTeam: self.awayOrHome)
    }
    @IBAction func takeFourBase( sender: AnyObject) {
        players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.addHit()
//        打者打擊率
        playerBA.text? = (players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getBA())!
//        打者打擊紀錄
        playerHit.text? = "\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getAtBat())!)-\((players[self.batters[self.awayOrHome][self.batterOn[self.awayOrHome]].text!]?.getHit())!)"
        //        投手紀錄
        if awayOrHome == 1{
             
            players[self.batters[0][0].text!]?.addER()
            players[self.batters[0][0].text!]?.addPitchH()
            pitchIP.text? = (players[self.batters[0][0].text!]?.getPitchIP())!
            pitchH.text? = (players[self.batters[0][0].text!]?.getPitchH())!
            pitchERA.text? = (players[self.batters[0][0].text!]?.getERA())!

        }else{
             
            players[self.batters[1][0].text!]?.addER()
            players[self.batters[1][0].text!]?.addPitchH()
            pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
            pitchH.text? = (players[self.batters[1][0].text!]?.getPitchH())!
            pitchERA.text? = (players[self.batters[1][0].text!]?.getERA())!
        }
        
        self.runner(batter: self.batterOn[self.awayOrHome], bases: 4)
        self.hitCheck(whichTeam: self.awayOrHome)
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
//    func updateName(){
//        homePlayer8.addhit()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateName()
        batters = [[awayPlayer1,awayPlayer2,awayPlayer3,awayPlayer4,awayPlayer5,awayPlayer6,awayPlayer7,awayPlayer8,awayPlayer9] , [homePlayer1,homePlayer2,homePlayer3,homePlayer4,homePlayer5,homePlayer6,homePlayer7,homePlayer8,homePlayer9]]
        
        //初始化選手資料
        awayPlayer1.text? = "Kevin"
        let kevin = Player(as: "Kevin" ,position: "P")
        players.updateValue(kevin, forKey: "Kevin")
        
        awayPlayer2.text? = "Robber"
        let robber = Player(as: "Robber" ,position: "C")
        players.updateValue(robber, forKey: "Robber")
        
        awayPlayer3.text? = "Green"
        let green = Player(as: "Green" ,position: "1B")
        players.updateValue(green, forKey: "Green")
        
        awayPlayer4.text? = "Anderson"
        let anderson = Player(as: "Anderson" ,position: "2B")
        players.updateValue(anderson, forKey: "Anderson")
        
        awayPlayer5.text? = "Bob"
        let bob = Player(as: "Bob" ,position: "3B")
        players.updateValue(bob, forKey: "Bob")
        
        awayPlayer6.text? = "Gray"
        let gray = Player(as: "Gray" ,position: "SS")
        players.updateValue(gray, forKey: "Gray")
        
        awayPlayer7.text? = "John"
        let john = Player(as: "John" ,position: "LF")
        players.updateValue(john, forKey: "John")
        
        awayPlayer8.text? = "Wright"
        let wright = Player(as: "Wright" ,position: "CF")
        players.updateValue(wright, forKey: "Wright")
        
        awayPlayer9.text? = "Denny"
        let denny = Player(as: "Denny" ,position: "RF")
        players.updateValue(denny, forKey: "Denny")
        
        homePlayer1.text? = "Ann"
        let ann = Player(as: "Ann" ,position: "P")
        players.updateValue(ann, forKey: "Ann")

        homePlayer2.text? = "Young"
        let young = Player(as: "Young" ,position: "C")
        players.updateValue(young, forKey: "Young")
        
        homePlayer3.text? = "Money"
        let money = Player(as: "Money" ,position: "1B")
        players.updateValue(money, forKey: "Money")
        
        homePlayer4.text? = "Fry"
        let fry = Player(as: "Fry" ,position: "2B")
        players.updateValue(fry, forKey: "Fry")
        
        homePlayer5.text? = "Carter"
        let carter = Player(as: "Carter" ,position: "3B")
        players.updateValue(carter, forKey: "Carter")
        
        homePlayer6.text? = "Penny"
        let penny = Player(as: "Penny" ,position: "SS")
        players.updateValue(penny, forKey: "Penny")
        
        homePlayer7.text? = "Len"
        let len = Player(as: "Len" ,position: "LF")
        players.updateValue(len, forKey: "Len")
        
        homePlayer8.text? = "Rose"
        let rose = Player(as: "Rose" ,position: "CF")
        players.updateValue(rose, forKey: "Rose")
        
        homePlayer9.text? = "Ted"
        let ted = Player(as: "Ted" ,position: "RF")
        players.updateValue(ted, forKey: "Ted")
        
        //開局投手資訊
        pitchName.text? = (players[self.batters[1][0].text!]?.getName())!
        pitchIP.text? = (players[self.batters[1][0].text!]?.getPitchIP())!
        pitchERA.text? = (players[self.batters[1][0].text!]?.getERA())!
        pitchH.text? = (players[self.batters[1][0].text!]?.getPitchH())!
        

        
       
        /*
        inningScore = [[top1,top2,top3,top4,top5,top6,top7,top8,top9],[bottom1,bottom2,bottom3,bottom4,bottom5,bottom6,bottom7,bottom8,bottom9]]
 */
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
