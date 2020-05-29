//
//  ViewController.swift
//  HybridCollectionView
//
//  Created by macmini3 on 19/02/20.
//  Copyright © 2020 macmini3. All rights reserved.
//

import UIKit

class TitleCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
}

class MainCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
}

class ViewController: UIViewController {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var colV: UICollectionView!
    @IBOutlet weak var colTitle: TitleCollectionView!
    
    var strechyViewHeight: CGFloat = 200    // 200    // Manually Assign whatever you want
                                            // For landscape view, mentioned below didRotate() method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colTitle.setup()
        colTitle.titleCollectionViewDelegate = self
        colTitle.titleCollectionViewDataSource = self
        colTitle.titleCollectionViewDelegateFlowLayout = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orientationChanged()
    }
    
    func orientationChanged() {
        topConstraint.constant = strechyViewHeight
        colV.reloadData()
        colTitle.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imgIcon.layer.cornerRadius = imgIcon.frame.height / 2
        imgIcon.clipsToBounds = true
        self.imgIcon.superview!.layoutIfNeeded()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if fromInterfaceOrientation.isLandscape {
            topConstraint.constant = strechyViewHeight
        }
        else {
            topConstraint.constant = 100     // set view height on landscape orientation
        }
        orientationChanged()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VCELL", for: indexPath) as! MainCell
        cell.layer.cornerRadius = 8.0
        cell.clipsToBounds = true
        cell.lblTitle.text = "Vertical Cell - \(indexPath.item)"
        cell.lblTitle.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        cell.lblTitle.textColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Vertical Scroll Tap : ",indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 32, height: colTitle.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topConstraint.constant, left: 0, bottom: 16, right: 0)
    }
}

extension ViewController: TitleCollectionViewDelegate, TitleCollectionViewDataSource, TitleCollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == colV {
            let scrollViewTopOffset = scrollView.contentOffset.y - scrollView.contentInset.top
            if ((strechyViewHeight + colTitle.frame.height) - scrollViewTopOffset) >= 0 {
                if (strechyViewHeight - scrollViewTopOffset) >= 0 {
                    topConstraint.constant = strechyViewHeight - scrollViewTopOffset
                }
                else {
                    topConstraint.constant = 0
                }
            }
            else {
                topConstraint.constant = 0
            }
            self.view!.layoutIfNeeded()
            
            // Use this logic if you're using tableview
            
            /*
             let scrollViewTopOffset = scrollView.contentOffset.y
             
             if (-scrollViewTopOffset) >= 44 {
             
             if (-scrollViewTopOffset) >= 44 {
             topConstraint.constant =  -scrollViewTopOffset
             }
             else {
             topConstraint.constant = 44
             }
             }
             else {
             topConstraint.constant = 44
             }
             self.view!.layoutIfNeeded()
             */
            
        }
    }
    
    func titleCollectionView(_ titleCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func titleCollectionView(_ titleCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = titleCollectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! TitleCell
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        cell.layer.cornerRadius = 8.0
        cell.clipsToBounds = true
        cell.lblTitle.text = "H - \(indexPath.item)"
        cell.lblTitle.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        cell.lblTitle.textColor = .white
        return cell
    }
    
    func titleCollectionView(_ titleCollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: colTitle.frame.height - 32)
    }
    
    func titleCollectionView(_ titleCollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func titleCollectionView(_ titleCollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func titleCollectionView(_ titleCollectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Horizontal Scroll Tap : ",indexPath.item)
    }
}
