//
//  ViewController.swift
//  QuizGame
//
//  Created by Gi Oo on 07.06.22.
//

import UIKit

/*
 Things we need
 - Menu screen
 - Game screen
 - Answer object
 - Question object
 */



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func startGame(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated:true)
    }

}



