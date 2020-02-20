//
//  TitleCollectionView.swift
//  GolKunda
//
//  Created by macmini3 on 19/02/20.
//  Copyright © 2020 Gatisofttech. All rights reserved.
//

import UIKit

@objc protocol TitleCollectionViewDelegate: class {
    @objc optional func titleCollectionView(_ titleCollectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

protocol TitleCollectionViewDataSource: class {
    func titleCollectionView(_ titleCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func titleCollectionView(_ titleCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

@objc protocol TitleCollectionViewDelegateFlowLayout: class {
    @objc optional func titleCollectionView(_ titleCollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    @objc optional func titleCollectionView(_ titleCollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    @objc optional func titleCollectionView(_ titleCollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    @objc optional func titleCollectionView(_ titleCollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
}

class TitleCollectionView: UICollectionView {
    
    weak var titleCollectionViewDelegate: TitleCollectionViewDelegate?
    weak var titleCollectionViewDataSource: TitleCollectionViewDataSource?
    weak var titleCollectionViewDelegateFlowLayout: TitleCollectionViewDelegateFlowLayout?
    
    func setup() {
        self.delegate = self
        self.dataSource = self
    }
}

extension TitleCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        titleCollectionViewDelegate?.titleCollectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
}

extension TitleCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleCollectionViewDataSource?.titleCollectionView(collectionView, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return titleCollectionViewDataSource?.titleCollectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
}

extension TitleCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return titleCollectionViewDelegateFlowLayout?.titleCollectionView?(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return titleCollectionViewDelegateFlowLayout?.titleCollectionView?(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return titleCollectionViewDelegateFlowLayout?.titleCollectionView?(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return titleCollectionViewDelegateFlowLayout?.titleCollectionView?(collectionView, layout: collectionViewLayout, insetForSectionAt: section) ?? .zero
    }
}
