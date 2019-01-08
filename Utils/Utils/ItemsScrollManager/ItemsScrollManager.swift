//
//  ItemsScrollManager.swift
//  Utils
//
//  Created by Александр Чаусов on 08/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

public final class ItemsScrollManager {

    // MARK: - Private Properties

    private let cellWidth: CGFloat
    private let cellOffset: CGFloat
    private let insets: UIEdgeInsets
    private var containerWidth: CGFloat

    private var beginDraggingOffset: CGFloat = 0
    private var lastOffset: CGFloat = 0
    private var currentPage: Int = 0

    // MARK: - Initialization

    public init(cellWidth: CGFloat, cellOffset: CGFloat, insets: UIEdgeInsets, containerWidth: CGFloat = UIScreen.main.bounds.width) {
        self.cellWidth = cellWidth
        self.cellOffset = cellOffset
        self.insets = insets
        self.containerWidth = containerWidth
    }

    // MARK: - Public Methods

    public func setBeginDraggingOffset(_ contentOffsetX: CGFloat) {
        beginDraggingOffset = contentOffsetX
    }

    public func setTargetContentOffset(_ targetContentOffset: UnsafeMutablePointer<CGPoint>, for scrollView: UIScrollView) {
        let pageWidth = cellWidth + cellOffset
        let firstCellOffset = insets.left - cellOffset
        var targetX = targetContentOffset.pointee.x
        var pageOffset: CGFloat = 0

        if beginDraggingOffset == targetX && scrollView.isDecelerating {
            // If we just tap somewhere we will not scroll to this point. We will use last offset
            targetX = lastOffset
        }

        if lastOffset > targetX {
            currentPage = Int(max(floor((targetX - firstCellOffset) / pageWidth), 0))
        } else if lastOffset < targetX {
            let targetOffset = max(targetX - firstCellOffset, 1)
            currentPage = Int(ceil(targetOffset / pageWidth))
        }

        pageOffset = currentPage == 0 ? 0 : CGFloat(currentPage) * pageWidth + firstCellOffset
        pageOffset = min(scrollView.contentSize.width - containerWidth, pageOffset)
        lastOffset = pageOffset
        targetContentOffset.pointee.x = pageOffset
    }

}
