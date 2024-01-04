//
//  ChooseTeamsViewController.swift
//  Project30.5-Milestone28-30
//
//  Created by suhail on 04/09/23.
//

import UIKit

class ChooseTeamsViewController: UIViewController {
    
    @IBOutlet var vwCard1: UIControl!
    @IBOutlet var vwCard2: UIControl!
    @IBOutlet var imgCard1: UIImageView!
    @IBOutlet var imgCArd2: UIImageView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        let attributes: [NSAttributedString.Key : Any] =  [.font:UIFont(name: "Copperplate", size: 24)!,
            .foregroundColor: UIColor.black]
        let str = NSAttributedString(string: "Choose Your Team", attributes: attributes )
        titleLabel.attributedText = str
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        defaults.set(true, forKey: "isLoggedIn")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
      
            vwCard1.layer.cornerRadius = 12
            vwCard1.layer.borderColor = UIColor.black.cgColor
            vwCard1.clipsToBounds = true
            vwCard1.layer.borderWidth = 0.9
            
            vwCard2.layer.cornerRadius = 12
            vwCard2.layer.borderColor = UIColor.black.cgColor
            vwCard2.clipsToBounds = true
            vwCard2.layer.borderWidth = 0.9
        
        
    
    }
    

    @IBAction func team1Tapped(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "cards") as? CardsLayoutViewController{
            //vc.cardType = imgCard1.image
            vc.heroT = heroType.dc
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    @IBAction func team2Tapped(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "cards") as? CardsLayoutViewController{
           // vc.cardType = imgCArd2.image
            vc.heroT = heroType.marvel
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func logOut(){
        defaults.set(false, forKey: "isLoggedIn")
        navigationController?.popToRootViewController(animated: true)
    }
}
