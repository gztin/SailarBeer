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
    
    @IBOutlet var codeInf: UILabel!
    @IBOutlet var oneDice: UIButton!
    @IBOutlet var twoDice: UIButton!
    @IBOutlet var threeDice: UIButton!
    @IBOutlet var MSG: UILabel!
    @IBOutlet var beerPic: UIImageView!
    @IBOutlet var gameMSG: UIImageView!
    @IBOutlet var playAgain: UIButton!
    
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
        
        if motion == .motionShake {
           codeInf.text = ""
            if gameover == false {
                AudioServicesPlaySystemSound(1521) // Actuate "Pop" feedback (strong boom)
                for _ in 1...diceCount {
                    tempDice = Int.random(in: 1...6)
                    sumOfDice = sumOfDice + tempDice
                    codeInf.text = String(sumOfDice)
                    print("總點數是\(sumOfDice)")
                }
                 
                 if sumOfDice >= diceCode {
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
