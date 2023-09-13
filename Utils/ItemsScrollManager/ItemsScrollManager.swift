//
//  ItemsScrollManager.swift
//  Utils
//
//  Created by Александр Чаусов on 08/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//
// swiftlint:disable line_length

import UIKit

/// Manager allows you to organize scrolling inside the carousel in such a way that
/// the new element always appears according to specified alignment.
/// To organize scrolling, it is enough to create an instance of the manager
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

    public enum CellAlignment {
        case left
        case centered
        case right
    }

    // MARK: - Private Properties

    private let cellWidth: CGFloat
    private let cellSpacing: CGFloat
    private let insets: UIEdgeInsets
    private let containerWidth: CGFloat
    private let alignment: CellAlignment

    private var beginDraggingOffset: CGFloat = 0
    private var lastOffset: CGFloat = 0

    private var pageWidth: CGFloat {
        cellWidth + cellSpacing
    }

    private var cellAlignmentOffset: CGFloat {
        switch alignment {
        case .left:
            return insets.left
        case .centered:
            return (containerWidth - cellWidth) / 2
        case .right:
            return (containerWidth - cellWidth) - insets.right
        }
    }

    // MARK: - Initialization

    /// Creates the manager.
    ///
    /// Example of usage:
    /// ```
    /// scrollManager = ItemsScrollManager(cellWidth: 200,
    ///                                    cellOffset: 10,
    ///                                    insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
    ///                                    alignment: .center)
    /// ```
    ///
    /// - Parameters:
    ///   - cellWidth: Items cell width
    ///   - cellOffset: Inter item space between two cells inside the carousel
    ///   - insets: Insets for section with carousel items in collection view
    ///   - containerWidth: Carousel width, by default equal to screen width
    ///   - alignment: Rule for cell placement relative to the container. Defaults to `.left` for compatibility with the old version usages
    public init(
        cellWidth: CGFloat,
        cellOffset: CGFloat,
        insets: UIEdgeInsets,
        containerWidth: CGFloat = UIScreen.main.bounds.width,
        alignment: CellAlignment = .left
    ) {
        self.cellWidth = cellWidth
        self.cellSpacing = cellOffset
        self.insets = insets
        self.containerWidth = containerWidth
        self.alignment = alignment
    }

    // MARK: - Public Methods

    /// Used to save the dragging offset when user starts dragging the scroll view.
    /// Should be called inside `UIScrollViewDelegate.scrollViewWillBeginDragging(...)`
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

    /// Used for replacing `targetContentOffset` when user ends dragging scroll view.
    /// Should be called inside `UIScrollViewDelegate.scrollViewWillEndDragging(...)`
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
    ///   - targetContentOffset: Scroll view `targetContentOffset` pointer from delegate method `scrollViewWillEndDragging(...)`
    ///   - scrollView: Scroll view with the carousel
    public func setTargetContentOffset(
        _ targetContentOffset: UnsafeMutablePointer<CGPoint>,
        for scrollView: UIScrollView
    ) {
        let targetOffset = targetContentOffset.pointee.x

        // If offset hasn't changed, keep current position
        if targetOffset == beginDraggingOffset, scrollView.isDecelerating {
            targetContentOffset.pointee.x = lastOffset
            return
        }

        // Detect on which page the scroll will end
        let pageProgress = getPageProgress(for: scrollView, targetOffset: targetOffset)
        let currentPage = pageProgress.rounded(scrollView.contentOffset.x < lastOffset ? .down : .up)

        // Detect which offset corresponds to the selected page
        let cellOffset = insets.left + currentPage * pageWidth - cellAlignmentOffset
        let normalizedOffset = min(max(0, cellOffset), scrollView.contentSize.width - containerWidth)

        // Save the result
        lastOffset = normalizedOffset
        targetContentOffset.pointee.x = normalizedOffset
    }

    /// Detects the number of scrolled pages considering the cell alignment
    /// Can be used to get page for `BeanPageControl` util
    /// - Parameters:
    ///   - targetOffset: offset value for which you need to determine the page. By default, it is current `contentOffset.x` of the `scrollView`
    public func getPageProgress(for scrollView: UIScrollView, targetOffset: CGFloat? = nil) -> CGFloat {
        let offset = targetOffset ?? scrollView.contentOffset.x

        // Edge pages are shorter than normal ones, because edge cells are always aligned to the edge of the container
        // Left offset for the first cell is `insets.left`, for normal ones - `cellAlignmentOffset`
        let firstPageWidth = pageWidth - (cellAlignmentOffset - insets.left)
        // Get progress for the first page
        if offset < firstPageWidth, firstPageWidth > 0 {
            return max(0, offset) / firstPageWidth
        }

        // Right offset for normal cells
        let reversedAdditionalOffset = containerWidth - (cellAlignmentOffset + cellWidth)
        // Right offset for the last cell is `insets.right`, for normal ones - `reversedAdditionalOffset`
        let lastPageWidth = pageWidth - (reversedAdditionalOffset - insets.right)
        // Get progress for the last page
        if offset > maxContentOffset(for: scrollView) - lastPageWidth, lastPageWidth > 0 {
            // Progress for the last page is calculated in reverse direction, then subtracted from the last page index
            let reversedProgress = (maxContentOffset(for: scrollView) - offset) / lastPageWidth
            let pagesCount = (scrollView.contentSize.width + cellSpacing - (insets.left + insets.right)) / pageWidth
            let lastPage = pagesCount - 1
            return lastPage - max(0, reversedProgress)
        }

        // For all other pages, the progress is calculated in the usual way, but taking into account the cell alignment
        return (offset - insets.left + cellAlignmentOffset) / pageWidth
    }

}

// MARK: - Private Methods

private extension ItemsScrollManager {

    func maxContentOffset(for scrollView: UIScrollView) -> CGFloat {
        return scrollView.contentSize.width - containerWidth
    }

}
