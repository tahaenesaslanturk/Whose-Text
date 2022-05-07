//
//  ViewController.swift
//  Whose Text
//
//  Created by Taha Enes Aslantürk on 7.05.2022.
//

import UIKit
import CoreML

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var whoseTextField: UITextField!
    @IBOutlet weak var whoseLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whoseTextField.delegate = self
        whoseTextField.returnKeyType = .done
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        whoseLabel.text = "???"
        whoseLabel.textColor = .black
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        whoseTextField.resignFirstResponder()
        makePrediciton()
        return true
    }
    
    
    

    @IBAction func findButtonPressed(_ sender: UIButton) {
        makePrediciton()
                
    }
    
    func makePrediciton() {
        if let predictText = whoseTextField.text {
            do {
                let textClassifier = try WhoseTextClassifier.init(configuration: MLModelConfiguration())
                let prediction = try! textClassifier.prediction(text: predictText)
                whoseLabel.text = prediction.label
                whoseLabel.textColor = .systemGreen
                whoseTextField.endEditing(true)
            } catch {
                print("Error when making prediciton \(error)")
            }
            
        }

        
        
    }
    
}

