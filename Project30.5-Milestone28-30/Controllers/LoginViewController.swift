//
//  ViewController.swift
//  Project30.5-Milestone28-30
//
//  Created by suhail on 04/09/23.
//
import LocalAuthentication
import UIKit

class LoginViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet var vwFace: UIControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let titleLabel = UILabel()
        let attributes: [NSAttributedString.Key : Any] =  [.font:UIFont(name: "Copperplate", size: 40)!,
            .foregroundColor: UIColor.black]
        
        let str = NSAttributedString(string: "Cards", attributes: attributes )
        titleLabel.attributedText = str
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        
        vwFace.layer.cornerRadius = 10
        vwFace.layer.borderColor = UIColor.black.cgColor
        vwFace.layer.borderWidth = 0.9
        
        let isLoggedIn = defaults.bool(forKey: "isLoggedIn")
        print("%%%%%")
        print(isLoggedIn)
        if isLoggedIn{
            unlock()
        }
        
    }

    
    @IBAction func biometricTapped(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Identify yourself!"
           
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, autheticationError in
              
                DispatchQueue.main.async {
                    if success{
                        self?.unlock()
                    }else{
                        let ac = UIAlertController(title: "Authentication Failed", message: "You could not be verified! Please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Ok", style: .default))
                        self?.present(ac,animated: true)
                    }
                }
            }
            
        }else{
            let ac = UIAlertController(title: "Biometry Unavailible", message: "Your device does not support biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac,animated: true)
        }
        
    }
    func unlock(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "chooseTeam") as? ChooseTeamsViewController{
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

