//
//  gameInfViewController.swift
//  SailarBeer
//
//  Created by 陳宗廷 on 2024/3/21.
//

import UIKit
import AVFoundation

class gameInfViewController: UIViewController {
    
    var click: AVAudioPlayer?
    var diceRoll: AVAudioPlayer?
    var losegame: AVAudioPlayer?
    
    var diceCode:Int!
    var diceCount:Int = 1
    var tempDice:Int = 0
    var sumOfDice:Int = 0
    var gameover:Bool = false
    var total:Int!
    
    @IBOutlet var codeInf: UILabel!
    @IBOutlet var oneDice: UIButton!
    @IBOutlet var twoDice: UIButton!
    @IBOutlet var threeDice: UIButton!
    @IBOutlet var MSG: UILabel!
    @IBOutlet var beerPic: UIImageView!
    @IBOutlet var gameMSG: UIImageView!
    @IBOutlet var playAgain: UIButton!
    
    @IBOutlet var oneDiceA: UIImageView!
    @IBOutlet var twoDiceA: UIImageView!
    @IBOutlet var twoDiceB: UIImageView!
    
    @IBOutlet var threeDiceA: UIImageView!
    @IBOutlet var threeDiceB: UIImageView!
    @IBOutlet var threeDiceC: UIImageView!
    
    @IBOutlet var cardView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        按鈕音效
        let urlClick = Bundle.main.url(forResource: "click", withExtension: "wav")!
        do {
            click = try AVAudioPlayer(contentsOf: urlClick)
        } catch {
            print("按鈕音效檔案出現錯誤：\(error)")
        }
        
        //        骰子音效
        let urlDice = Bundle.main.url(forResource: "dice", withExtension: "wav")!
        do {
            diceRoll = try AVAudioPlayer(contentsOf: urlDice)
        } catch {
            print("擲骰子音效檔案出現錯誤：\(error)")
        }
        
        //        遊戲結束音效
        let urllose = Bundle.main.url(forResource: "gamelose", withExtension: "mp3")!
        do {
            losegame = try AVAudioPlayer(contentsOf: urllose)
        } catch {
            print("擲骰子音效檔案出現錯誤：\(error)")
        }
        
        hideBackButton()
        beerPic.layer.opacity = 0
        oneDice.layer.borderWidth = 3
        twoDice.layer.borderWidth = 0
        threeDice.layer.borderWidth = 0
        oneDice.layer.cornerRadius = 20
        twoDice.layer.cornerRadius = 20
        threeDice.layer.cornerRadius = 20
        MSG.text = "本局目標點數是： \(String(diceCode))"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func playAgain(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
        
        playAgain.layer.opacity = 0
        codeInf.text = "0"
        sumOfDice = 0
        beerPic.layer.opacity = 0
        diceCode = Int.random(in: 50...100)
        MSG.text = "本局目標點數是： \(String(diceCode))"
        gameover = false
    }
    func hideBackButton(){
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func playOne(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
        
        AudioServicesPlaySystemSound(1519) // Actuate "Pop" feedback (strong boom)
        diceCount = 1
        oneDice.layer.borderWidth = 3
        twoDice.layer.borderWidth = 0
        threeDice.layer.borderWidth = 0
        oneDice.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
    }
    @IBAction func playTwo(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
        
        AudioServicesPlaySystemSound(1519) // Actuate "Pop" feedback (strong boom)
        diceCount = 2
        oneDice.layer.borderWidth = 0
        twoDice.layer.borderWidth = 3
        threeDice.layer.borderWidth = 0
        twoDice.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
    }
    @IBAction func playThree(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
        
        AudioServicesPlaySystemSound(1519) // Actuate "Pop" feedback (strong boom)
        diceCount = 3
        oneDice.layer.borderWidth = 0
        twoDice.layer.borderWidth = 0
        threeDice.layer.borderWidth = 3
        threeDice.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
    }
    //    搖晃
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        diceRoll?.play()
        diceRoll?.stop()
        diceRoll?.currentTime = 0
        diceRoll?.play()
        cardView.layer.opacity = 0
        
        total = 0
        oneDiceA.layer.opacity = 0
        twoDiceA.layer.opacity = 0
        twoDiceB.layer.opacity = 0
        threeDiceA.layer.opacity = 0
        threeDiceB.layer.opacity = 0
        threeDiceC.layer.opacity = 0
        
        if motion == .motionShake {
           codeInf.text = ""
            if gameover == false {
                AudioServicesPlaySystemSound(1521) // Actuate "Pop" feedback (strong boom)
                if diceCount == 1{
                    tempDice = Int.random(in: 1...6)
                    oneDiceA.image = UIImage(named: "\(tempDice)-dice.jpg")
                    oneDiceA.layer.opacity = 1
                    sumOfDice = sumOfDice + tempDice
                    codeInf.text = String(sumOfDice)
                }else if diceCount == 2{
                    for i in 1...diceCount {
                        tempDice = Int.random(in: 1...6)
                        if i==1 {
                            twoDiceA.image = UIImage(named: "\(tempDice)-dice.jpg")
                            twoDiceA.layer.opacity = 1
                            total = total + tempDice
                        }else if i==2{
                            twoDiceB.image = UIImage(named: "\(tempDice)-dice.jpg")
                            twoDiceB.layer.opacity = 1
                            total = total + tempDice
                        }
                    }
                    if (total == 2) && ((diceCode - sumOfDice) < 15){
                        cardView.image = UIImage(named: "card1")
                        cardView.layer.opacity = 1
                        twoDiceA.layer.opacity = 0
                        twoDiceB.layer.opacity = 0
                        print("獲得迴轉卡")
                        codeInf.text = String(sumOfDice)
                    }else if(total == 7) && ((diceCode - sumOfDice) < 15){
                        cardView.image = UIImage(named: "card2")
                        cardView.layer.opacity = 1
                        twoDiceA.layer.opacity = 0
                        twoDiceB.layer.opacity = 0
                        print("獲得暫停卡")
                        codeInf.text = String(sumOfDice)
                    }else if(total == 12) && ((diceCode - sumOfDice) < 15){
                        cardView.image = UIImage(named: "card3")
                        cardView.layer.opacity = 1
                        twoDiceA.layer.opacity = 0
                        twoDiceB.layer.opacity = 0
                        print("獲得指定卡")
                        codeInf.text = String(sumOfDice)
                    }else{
                        sumOfDice = sumOfDice + total
                        codeInf.text = String(sumOfDice)
                        print("總點數是\(sumOfDice)")
                    }
                }else if diceCount == 3{
                    for i in 1...diceCount {
                        tempDice = Int.random(in: 1...6)
                        if i==1{
                            threeDiceA.image = UIImage(named: "\(tempDice)-dice.jpg")
                            threeDiceA.layer.opacity = 1
                            total = total + tempDice
                        }else if i==2{
                            threeDiceB.image = UIImage(named: "\(tempDice)-dice.jpg")
                            threeDiceB.layer.opacity = 1
                            total = total + tempDice
                        }else if i==3{
                            threeDiceC.image = UIImage(named: "\(tempDice)-dice.jpg")
                            threeDiceC.layer.opacity = 1
                            total = total + tempDice
                        }
                    }
                    if ((total == 18) || (total == 12)) && ((diceCode - sumOfDice) < 25){
                        cardView.image = UIImage(named: "card3")
                        cardView.layer.opacity = 1
                        threeDiceA.layer.opacity = 0
                        threeDiceB.layer.opacity = 0
                        threeDiceC.layer.opacity = 0
                        codeInf.text = String(sumOfDice)
                        print("獲得指定卡")
                    }else if(total == 7) && ((diceCode - sumOfDice) < 25){
                        cardView.image = UIImage(named: "card2")
                        cardView.layer.opacity = 1
                        threeDiceA.layer.opacity = 0
                        threeDiceB.layer.opacity = 0
                        threeDiceC.layer.opacity = 0
                        codeInf.text = String(sumOfDice)
                    }else if(total == 3) && ((diceCode - sumOfDice) < 25){
                        cardView.image = UIImage(named: "card1")
                        cardView.layer.opacity = 1
                        threeDiceA.layer.opacity = 0
                        threeDiceB.layer.opacity = 0
                        threeDiceC.layer.opacity = 0
                        codeInf.text = String(sumOfDice)
                    }else{
                        sumOfDice = sumOfDice + total
                        codeInf.text = String(sumOfDice)
                        print("總點數是\(sumOfDice)")
                    }
                }
                

                 if sumOfDice >= diceCode {
                     oneDiceA.layer.opacity = 0
                     twoDiceA.layer.opacity = 0
                     twoDiceB.layer.opacity = 0
                     threeDiceA.layer.opacity = 0
                     threeDiceB.layer.opacity = 0
                     threeDiceC.layer.opacity = 0
                     
                     losegame?.play()
                     losegame?.stop()
                     losegame?.currentTime = 0
                     losegame?.play()
                     
                     beerPic.layer.opacity = 1
                     playAgain.layer.opacity = 1
                     MSG.layer.opacity = 1
                     gameover = true
                 }
            }
            else{
                codeInf.text = String(sumOfDice)
            }

        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
