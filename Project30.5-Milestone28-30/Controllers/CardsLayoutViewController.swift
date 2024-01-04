//
//  CardsLayoutViewController.swift
//  Project30.5-Milestone28-30
//
//  Created by suhail on 04/09/23.
//
import AVFoundation
import UIKit


class CardsLayoutViewController: UIViewController {
    let defaults = UserDefaults.standard
    var heroT: heroType?
    var team : String?
    var dcHeros = ["batman","flash","reverseFlash","wonderWoman","superman","greenLantern"]
    var marvelHeros = ["cap","hulk","ironMan","spidey","strange","thor"]
    var heros12 = [String]()
    var unflippedImage = [String](repeating:"eagle" , count: 12)
    var tap = 0
    var cardFlipSound: AVAudioPlayer?
    var selectedCards = [String]()
    var cardsIndexPath = [Int]()
    var score = 0
    var hits = 0{
        didSet{
            setTitle()
        }
    }
    @IBOutlet var col: UICollectionView!{
        didSet{
            self.col.register(CardsCollectionViewCell.nib, forCellWithReuseIdentifier: CardsCollectionViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        col.dataSource = self
        col.delegate = self
        col.isUserInteractionEnabled = true
        if heroT == .dc{
            //team = heroType.dc.rawValue
            team = "justiceLeague"
        }else{
            team = "avengers"
        }
        unflippedImage = [String](repeating: team ?? "eagle" , count: 12)
        if heroT == .dc {
            heros12 = make12Heros(heros: dcHeros)
        }else{
            heros12 = make12Heros(heros: marvelHeros)
        }
        
        
    }
    
    
    func make12Heros(heros: [String])->[String]{
        heros12 = heros.shuffled()
        let temp = heros12.shuffled()
        heros12.append(contentsOf: temp)
        heros12.shuffle()
        return heros12
    }
    
}
extension CardsLayoutViewController: UICollectionViewDelegate,
                                     UICollectionViewDataSource,
                                     UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros12.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardsCollectionViewCell.identifier, for: indexPath) as! CardsCollectionViewCell
        
        cell.imgCard.image = UIImage(named: unflippedImage[indexPath.row])
        if unflippedImage[indexPath.row] == "swoosh"{
            cell.isHidden = true
        }else{
            cell.isHidden = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tap += 1
        
        if tap<3{
            
            unflippedImage[indexPath.row] = heros12[indexPath.row]
            selectedCards.append(heros12[indexPath.row])
            cardsIndexPath.append(indexPath.row)
            DispatchQueue.main.async{
                self.col.reloadData()
            }
            playSound(name: "cardflip", ext: "wav")
            
        }
        
        if tap==2{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
                // your code here
                self?.judgeCards()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (col.bounds.width/3)-14, height: (col.bounds.height/4)-13)
    }
    
    
}
//user functions
extension CardsLayoutViewController{
    func judgeCards(){
        hits += 1
        if selectedCards[0]==selectedCards[1]{
            print("Cards Match")
            score+=1
            selectedCards.removeAll()
            unflippedImage[cardsIndexPath[0]] = "swoosh"
            unflippedImage[cardsIndexPath[1]] = "swoosh"
            
            
            
            DispatchQueue.main.async{ [weak self] in
                self?.playSound(name: "success", ext: "mp3")
                self?.col.reloadData()
            }
            
            cardsIndexPath.removeAll()
            if score == 6 {
                endGame()
            }
            tap = 0
        }else{
            print("Cards Dont Match")
            selectedCards.removeAll()
            
            unflippedImage[cardsIndexPath[0]] = team!
            unflippedImage[cardsIndexPath[1]] = team!
            
            DispatchQueue.main.async{
                self.col.reloadData()
            }
            
            cardsIndexPath.removeAll()
            
            tap = 0
        }
    }
    
    func playSound(name:String,ext:String){
        
        if let path = Bundle.main.path(forResource: name, ofType: ext) {
            let url = URL(fileURLWithPath: path)
            do {
                cardFlipSound = try AVAudioPlayer(contentsOf: url)
                cardFlipSound?.play()
            } catch  {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func setTitle(){
        let titleLabel = UILabel()
        let attributes: [NSAttributedString.Key : Any] =  [.font:UIFont(name: "Copperplate", size: 40)!,
                                                           .foregroundColor: UIColor.black]
        
        let str = NSAttributedString(string: "Hits: \(hits)", attributes: attributes )
        titleLabel.attributedText = str
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    func endGame(){
        let ac = UIAlertController(title: "Game Over", message: "You tapped \(hits) times", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        present(ac, animated: true)
    }
}
