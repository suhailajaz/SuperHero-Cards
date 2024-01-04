//
//  CardsCollectionViewCell.swift
//  Project30.5-Milestone28-30
//
//  Created by suhail on 04/09/23.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    static let identifier = "cardCvCell"
    static let nib = UINib(nibName: "CardsCollectionViewCell", bundle: nil)
    
    @IBOutlet var vwCardBg: UIControl!
    @IBOutlet var imgCard: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vwCardBg.layer.cornerRadius = 12
        vwCardBg.layer.borderColor = UIColor.black.cgColor
        vwCardBg.clipsToBounds = true
        vwCardBg.layer.borderWidth = 0.9
    }

}
