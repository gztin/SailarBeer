//
//  setplayerViewController.swift
//  SailarBeer
//
//  Created by 陳宗廷 on 2024/3/21.
//

import UIKit
import AVFoundation

class setplayerViewController: UIViewController {
    var diceNumber:Int!
    
    //    按鈕播放器
    var click: AVAudioPlayer?
    
    @IBOutlet var randomA: UIButton!
    @IBOutlet var randomB: UIButton!
    @IBOutlet var playGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        按鈕音效
        let urlClick = Bundle.main.url(forResource: "click", withExtension: "wav")!
        do {
            click = try AVAudioPlayer(contentsOf: urlClick)
        } catch {
            print("按鈕音效檔案出現錯誤：\(error)")
        }
        
        hideBackButton()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func randomA(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
        
        randomA.layer.borderWidth = 3
        randomB.layer.borderWidth = 0
        randomA.layer.cornerRadius = 20
        randomB.layer.cornerRadius = 0
        randomA.layer.borderColor = UIColor.black.cgColor
        diceNumber = Int.random(in: 30...50)
        playGame.layer.opacity = 1
        print("本次的死亡密碼是\(String(describing: diceNumber))")
        
    }
    
    @IBAction func randomB(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
        
        randomB.layer.borderWidth = 3
        randomA.layer.borderWidth = 0
        randomA.layer.cornerRadius = 0
        randomB.layer.cornerRadius = 20
        randomB.layer.borderColor = UIColor.black.cgColor
        diceNumber = Int.random(in: 50...100)
        playGame.layer.opacity = 1
        print("本次的死亡密碼是\(String(describing: diceNumber))")
        
    }
    
    @IBSegueAction func showNumber(_ coder: NSCoder) -> gameInfViewController? {
        let controller =  gameInfViewController(coder: coder)
        controller?.diceCode = diceNumber
        return controller
    }
    func hideBackButton(){
        navigationItem.hidesBackButton = true
    }
    @IBAction func starPlay(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
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
