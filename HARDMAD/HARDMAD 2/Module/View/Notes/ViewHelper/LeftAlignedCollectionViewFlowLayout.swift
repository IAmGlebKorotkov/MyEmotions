//
//  LeftAlignedCollectionViewFlowLayout.swift
//  HARDMAD 2
//
//  Created by Gleb Korotkov on 04.03.2025.
//

import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin: CGFloat = 0
        var lastY: CGFloat = -1
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y != lastY {
                leftMargin = 0
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            lastY = layoutAttribute.frame.origin.y
        }
        return attributes
    }
}
