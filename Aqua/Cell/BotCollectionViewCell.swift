//
//  BotCollectionViewCell.swift
//  Aqua
//
//  Created by Pyae Phyo Oo on 12/10/2024.
//

import Foundation
import UIKit

protocol BotCellProtocol: AnyObject {
    func toNav()
}

class BotCollectionViewCell: UICollectionViewCell {
    
    weak var delegte: BotCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI() {
        
    }
    
    @IBAction func didTappedBtn(_ sender: Any) {
        self.delegte?.toNav()
    }
}
