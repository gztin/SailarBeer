//
//  ViewController.swift
//  SailarBeer
//
//  Created by 陳宗廷 on 2024/3/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //    按鈕播放器
    var click: AVAudioPlayer?
    
    @IBOutlet var indexView: UIImageView!
    @IBOutlet var gameBgView: UIImageView!
    
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
    func hideBackButton(){
        navigationItem.hidesBackButton = true
    }
    @IBAction func step1(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
    }
    @IBAction func step2(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
    }
    @IBAction func step3(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
    }
    @IBAction func tapButton(_ sender: Any) {
        click?.play()
        click?.stop()
        click?.currentTime = 0
        click?.play()
    }
}

