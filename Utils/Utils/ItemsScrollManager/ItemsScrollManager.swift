//
//  ItemsScrollManager.swift
//  Utils
//
//  Created by Александр Чаусов on 08/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

/// Manager allows you to organize the scroll inside the carousel in such a way that
/// the beginning of a new element always appears on the left of the screen.
/// To organize a scroll, it is enough to create an instance of the manager
/// and call two of its methods at the necessary points described in the example below.
///
/// Example of usage:
/// ```
/// // Create manager
/// scrollManager = ItemsScrollManager(cellWidth: 200,
///                                    cellOffset: 10,
///                                    insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
///
/// // And call two of its methods inside the UISCrollViewDelegate methods
/// extension ViewController: UIScrollViewDelegate {
///
///     func scrollViewWillEndDragging(_ scrollView: UIScrollView,
///                                    withVelocity velocity: CGPoint,
///                                    targetContentOffset: UnsafeMutablePointer<CGPoint>) {
///         scrollManager?.setTargetContentOffset(targetContentOffset, for: scrollView)
///     }
///
///     func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
///         scrollManager?.setBeginDraggingOffset(scrollView.contentOffset.x)
///     }
///
/// }
/// ```
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

    /// Init method for the manager.
    ///
    /// Example of usage:
    /// ```
    /// scrollManager = ItemsScrollManager(cellWidth: 200,
    ///                                    cellOffset: 10,
    ///                                    insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    /// ```
    ///
    /// - Parameters:
    ///   - cellWidth: Items cell width
    ///   - cellOffset: Inter item space between two items inside the carousel
    ///   - insets: Insets for section with carousel items in collection view
    ///   - containerWidth: Carousel width, by default equal to screen width
    public init(cellWidth: CGFloat, cellOffset: CGFloat,
                insets: UIEdgeInsets, containerWidth: CGFloat = UIScreen.main.bounds.width) {
        self.cellWidth = cellWidth
        self.cellOffset = cellOffset
        self.insets = insets
        self.containerWidth = containerWidth
    }

    // MARK: - Public Methods

    /// This method is used for setup begin dragging offset, when user start dragging scroll view.
    /// You have to call this method inside UIScrollViewDelegate method scrollViewWillBeginDragging(...)
    ///
    /// Example of usage:
    /// ```
    /// func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    ///     scrollManager?.setBeginDraggingOffset(scrollView.contentOffset.x)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - contentOffsetX: Scroll view content offset by X axis
    public func setBeginDraggingOffset(_ contentOffsetX: CGFloat) {
        beginDraggingOffset = contentOffsetX
    }

    /// This is main method, it used for update scroll view targetContentOffset, when user end dragging scroll view.
    /// You have to call this method inside UIScrollViewDelegate method scrollViewWillEndDragging(...)
    ///
    /// Example of usage:
    /// ```
    /// func scrollViewWillEndDragging(_ scrollView: UIScrollView,
    ///                                withVelocity velocity: CGPoint,
    ///                                targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    ///     scrollManager?.setTargetContentOffset(targetContentOffset, for: scrollView)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - targetContentOffset: Scroll view targetContentOffset from delegate method scrollViewWillEndDragging(...)
    ///   - scrollView: Scroll view with carousel
    public func setTargetContentOffset(_ targetContentOffset: UnsafeMutablePointer<CGPoint>,
                                       for scrollView: UIScrollView) {
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
