//
//  ViewController.swift
//  Aqua
//
//  Created by Pyae Phyo Oo on 12/10/2024.
//

import UIKit
import FSPagerView

class ViewController: UIViewController {

    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var pageControler: FSPageControl!
    @IBOutlet weak var topCollectionView: SelfSizingCollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var botCollectionView: UICollectionView!
    
    let numberOfItemsInRow : CGFloat = 5.0
    var numberOfRows : Int = 0
    let image = [
        "ic_map",
        "ic_fish",
        "ic_letter",
        "ic_bag",
        "ic_spoon",
        "ic_communicate"
    ]
    
    fileprivate var starPath: UIBezierPath {
        let width = 10
        let height = 3
        let rectPath = UIBezierPath(rect: CGRect(x: width / 2 - 20, y: height / 2 - 5 , width: 20, height: height))
        rectPath.lineWidth = 10
        rectPath.stroke()
        return rectPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "nav_title")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        let imageLeft = UIImage(named: "ic_back")
        let imageViewLeft = UIImageView(image: imageLeft)
        imageViewLeft.contentMode = .scaleAspectFit
        let imageItemLeft = UIBarButtonItem.init(customView: imageViewLeft)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -25
        navigationItem.leftBarButtonItems = [negativeSpacer, imageItemLeft]
        
        let imageRight = UIImage(named: "ic_noti")
        let imageViewRight = UIImageView(image: imageRight)
        imageViewRight.contentMode = .scaleAspectFit
        let imageItemRight = UIBarButtonItem.init(customView: imageViewRight)
        navigationItem.rightBarButtonItem = imageItemRight
        setupPagerView()
        setUpCollectionView()
        setUpShadow()
        setUpBotCollectionView()
    }
    
    private func setupPagerView(){
        pageControler.backgroundColor = .clear
        pagerView.backgroundColor = .clear
        pagerView.clipsToBounds = true
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.tintColor = .white
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        pageControler.numberOfPages = 3
        pageControler.interitemSpacing = 20
        pageControler.setFillColor(UIColor.white, for: .normal)
        pageControler.setFillColor(UIColor.orange, for: .selected)
        pageControler.setPath(starPath, for: .normal)
        pageControler.setPath(starPath, for: .selected)
        pageControler.hidesForSinglePage = true
        pagerView.reloadData()
    }
    
    private func setUpCollectionView() {
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        topCollectionView.registerForCells(cells: TopCollectionViewCell.self)
        let layout = topCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = (topCollectionView.bounds.width - 20) / numberOfItemsInRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.1)
        let totalCount = 6
        numberOfRows = (totalCount % Int(numberOfItemsInRow) ) != 0 ? (totalCount / Int(numberOfItemsInRow) ) + 1 : (totalCount / Int(numberOfItemsInRow) )
        heightConstraint.constant = (itemWidth * 1.1) * CGFloat(numberOfRows) + 30
    }
    
    private func setUpBotCollectionView() {
        botCollectionView.delegate = self
        botCollectionView.dataSource = self
        botCollectionView.isScrollEnabled = true
        botCollectionView.registerForCells(cells: BotCollectionViewCell.self)
    }
    
    private func setUpShadow() {
        firstView.dropShadow(color: .black, opacity: 0.2, offSet: CGSize(width: -1, height: 1), radius: 15, scale: true)
        secondView.dropShadow(color: .black, opacity: 0.2, offSet: CGSize(width: -1, height: 1), radius: 15, scale: true)
    }
}

extension ViewController: FSPagerViewDelegate , FSPagerViewDataSource {
    
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
        pageControler.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageControler.currentPage = pagerView.currentIndex
    }
}

extension ViewController: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView {
            return 6
        } else {
            return 2
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topCollectionView {
            let cell = topCollectionView.dequeReuseCell(type: TopCollectionViewCell.self, indexPath: indexPath)
            cell.imgCollection.image = UIImage(named: image[indexPath.row])
            return cell
        } else {
            let cell = botCollectionView.dequeReuseCell(type: BotCollectionViewCell.self, indexPath: indexPath)
            cell.delegte = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topCollectionView {
            let itemWidth = (collectionView.bounds.width - 20 ) / numberOfItemsInRow
            return  CGSize(width: itemWidth, height: itemWidth * 1.1)
        } else {
            return CGSize(width: 200, height: collectionView.bounds.height)
        }
    }
    
}

extension ViewController: BotCellProtocol {
    
    func toNav() {
        let storyboard: UIStoryboard = UIStoryboard(name: "SecondVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        self.present(vc, animated: true)
    }
}

