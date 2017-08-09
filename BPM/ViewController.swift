//
//  ViewController.swift
//  BPM
//
//  Created by mesh:ine on 16/05/2017.
//  Copyright © 2017 mesh:ine. All rights reserved.
//

import UIKit
//Fais marcher la virgule pour les BPMs
//extension String {
//    var floatValue: Float {
//        let nf = NumberFormatter()
//        nf.decimalSeparator = "."
//        if let result = nf.number(from: self) {
//            return result.floatValue
//        } else {
//            nf.decimalSeparator = ","
//            if let result = nf.number(from: self) {
//                return result.floatValue
//            }
//        }
//        return 0
//    }
//}

//Cache clavier quand tape autre part
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

/*Flou sur le background qui est appelé dans le main*/
extension UIImageView
{
    func addBlurEffect()
    {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //blurEffectView.alpha = 0.6
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
            self.addSubview(blurEffectView)
        }
        else
        {
            print("Transparency disabled!! no blur view")
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var boutonClear: UIButton!
    @IBOutlet weak var boutonCalcul: UIButton!
    @IBOutlet weak var labelAffichage: UILabel!
    @IBOutlet weak var champDepart: UITextField!
    @IBOutlet weak var champArrivee: UITextField!
    @IBOutlet weak var boutonInvert: UIButton!
    //@IBOutlet weak var champPourcentage: UITextField!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        boutonCalcul.layer.cornerRadius = 10
        boutonClear.layer.cornerRadius = 15
        champDepart.layer.cornerRadius = 10
        champArrivee.layer.cornerRadius = 10
        champDepart.keyboardType=UIKeyboardType.decimalPad
        champArrivee.keyboardType=UIKeyboardType.decimalPad
        boutonInvert.layer.cornerRadius=15
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg")
        self.view.insertSubview(backgroundImage, at: 0)
        //backgroundImage.addBlurEffect()
    }
    
    @IBAction func calculPourcentageBouton(_ sender: UIButton) {
        let a = Float(champDepart.text!)
        let b = Float(champArrivee.text!)
        var purce : Float = 0.00
        if a != nil, b != nil {
            if a! < b! {
                purce = ((100)*(b!-a!)/a!)
                print(purce)
            } else if (b! < a!) {
                //En faites ca donne le meme resultat que la premiere condition mais avec un moins devant je pense
                purce = ((100)*(b!-a!)/a!)
                print(purce)
            }
            labelAffichage.text = "\(purce)"+"%"
        }
        
    }
    
    @IBAction func boutonClearPression(_ sender: UIButton) {
        champDepart.text=""
        champArrivee.text=""
        labelAffichage.text="BPM"
    }
    
    @IBAction func boutonInvertPression(_ sender: UIButton) {
        let c = champDepart.text
        champDepart.text = champArrivee.text
        champArrivee.text = c
    }
    
    
    func conversionChampVirgule( mot:String) ->String{
        var mott = mot
        mott = mott.replacingOccurrences(of: ",", with: ".")
        return mott
    }
}

