//
//  SecondVC.swift
//  Aqua
//
//  Created by Pyae Phyo Oo on 12/10/2024.
//

import Foundation
import UIKit
import FSPagerView

class SecondVC: UIViewController {
    
    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var pageControl: FSPageControl!
    @IBOutlet weak var viewWalk: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPagerView()
        viewWalk.layer.borderWidth = 1
        viewWalk.layer.borderColor = UIColor.black.cgColor
    }
    
    fileprivate var starPath: UIBezierPath {
        let width = 10
        let height = 3
        let rectPath = UIBezierPath(rect: CGRect(x: width / 2 - 150, y: height / 2 - 5 , width: 20, height: height))
        rectPath.lineWidth = 10
        rectPath.stroke()
        return rectPath
    }
    
    private func setupPagerView(){
        pageControl.backgroundColor = .clear
        pagerView.backgroundColor = .clear
        pagerView.clipsToBounds = true
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.tintColor = .white
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        pageControl.numberOfPages = 3
        pageControl.interitemSpacing = 20
        pageControl.setFillColor(UIColor.white, for: .normal)
        pageControl.setFillColor(UIColor.orange, for: .selected)
        pageControl.setPath(starPath, for: .normal)
        pageControl.setPath(starPath, for: .selected)
        pageControl.hidesForSinglePage = true
        pagerView.reloadData()
    }
    
    @IBAction func didTapCross(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension SecondVC: FSPagerViewDelegate , FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.clipsToBounds = true
        cell.imageView?.image = UIImage(named: "fish")
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.backgroundColor = .clear
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageControl.currentPage = pagerView.currentIndex
    }
}
