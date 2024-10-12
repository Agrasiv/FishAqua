//
//  TopCollectionViewCell.swift
//  Aqua
//
//  Created by Pyae Phyo Oo on 12/10/2024.
//

import Foundation
import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgCollection: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI() {
        bgView.layer.cornerRadius = bgView.frame.height / 2
    }
}
