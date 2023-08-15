//
//  ItemsScrollManagerViewController.swift
//  UtilsExample
//
//  Created by Дмитрий Демьянов on 14.08.2023.
//
// swiftlint:disable line_length

import UIKit
import Utils

final class ItemsScrollManagerViewController: UIViewController {

    // MARK: - Nested Types

    typealias Cell = ItemsScrollManagerExampleCell
    typealias Parameter = ItemsScrollManagerParameterView.Model

    private enum Parameters {
        static let cellCount = Parameter(title: "Cell count", minValue: 1, maxValue: 24, initialValue: 8)
        static let cellSpacing = Parameter(title: "Cell spacing", minValue: 0, maxValue: 128, initialValue: 10)
        static let cellWidth = Parameter(title: "Cell width", minValue: 32, maxValue: 400, initialValue: 128)
        static let edgeInsets = Parameter(title: "Edge insets", minValue: 0, maxValue: 128, initialValue: 10)
    }

    // MARK: - IBOutlets

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var collectionLayout: UICollectionViewFlowLayout!
    @IBOutlet private var parametersContainer: UIView!
    @IBOutlet private var parametersStackView: UIStackView!

    // MARK: - Private Properties

    private var pageControl: BeanPageControl?

    private var cellCount = Parameters.cellCount.initialValue
    private var cellAlignment: ItemsScrollManager.CellAlignment = .left
    private var scrollManager: ItemsScrollManager?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

}

// MARK: - UICollectionViewDataSource

extension ItemsScrollManagerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath)
        if let cell = cell as? Cell {
            cell.configure(with: indexPath.item)
        }
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension ItemsScrollManagerViewController: UICollectionViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollManager?.setBeginDraggingOffset(scrollView.contentOffset.x)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollManager?.setTargetContentOffset(targetContentOffset, for: scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = scrollManager?.getPageProgress(for: scrollView) ?? .zero
        pageControl?.set(index: Int(progress), progress: progress.truncatingRemainder(dividingBy: 1))
    }

}

// MARK: - Private Methods

private extension ItemsScrollManagerViewController {

    func setupInitialState() {
        setupCollectionView()
        setupParameters()
    }

    func setupCollectionView() {
        collectionView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        collectionView.decelerationRate = .init(rawValue: 0.1)
        collectionView.showsHorizontalScrollIndicator = false
        collectionLayout.sectionInset.left = .init(Parameters.edgeInsets.initialValue)
        collectionLayout.sectionInset.right = .init(Parameters.edgeInsets.initialValue)

        collectionLayout.scrollDirection = .horizontal
        collectionLayout.minimumLineSpacing = .init(Parameters.cellSpacing.initialValue)
        collectionLayout.itemSize = .init(width: Parameters.cellWidth.initialValue, height: Parameters.cellWidth.initialValue)

        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        resetView()
    }

    func setupParameters() {
        setupParametersContainer()

        addParameter(with: Parameters.cellCount) { [weak self] value in
            self?.cellCount = value
        }

        addParameter(with: Parameters.cellSpacing) { [weak self] value in
            self?.collectionLayout.minimumLineSpacing = .init(value)
        }

        addParameter(with: Parameters.cellWidth) { [weak self] value in
            self?.collectionLayout.itemSize.width = .init(value)
        }

        addParameter(with: Parameters.edgeInsets) { [weak self] value in
            self?.collectionLayout.sectionInset.left = .init(value)
            self?.collectionLayout.sectionInset.right = .init(value)
        }

        addAlignmentParameter()
    }

    func setupParametersContainer() {
        parametersContainer.layer.cornerRadius = 16

        parametersContainer.layer.shadowColor = UIColor.black.cgColor
        parametersContainer.layer.shadowOpacity = 0.3
        parametersContainer.layer.shadowOffset = .init(width: 0, height: 1)
    }

    func addAlignmentParameter() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        parametersStackView.addArrangedSubview(stackView)

        let titleLabel = UILabel()
        titleLabel.text = "Alignment"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)

        let alignmentControl = UISegmentedControl(items: ["Left", "Center", "Right"])
        alignmentControl.selectedSegmentIndex = 0
        alignmentControl.addTarget(self, action: #selector(alignmentValueChanged), for: .valueChanged)
        alignmentControl.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(alignmentControl)
        alignmentControl.widthAnchor.constraint(equalToConstant: 218).isActive = true
    }

    func addParameter(with model: Parameter, onChanged: ((Int) -> Void)?) {
        let parameterView = ItemsScrollManagerParameterView()
        parameterView.translatesAutoresizingMaskIntoConstraints = false
        parametersStackView.addArrangedSubview(parameterView)

        parameterView.configure(with: model)
        parameterView.onValueChanged = { [weak self] value in
            onChanged?(value)
            self?.resetView()
        }
    }

    func resetView() {
        scrollManager = ItemsScrollManager(
            cellWidth: collectionLayout.itemSize.width,
            cellOffset: collectionLayout.minimumLineSpacing,
            insets: collectionLayout.sectionInset,
            alignment: cellAlignment
        )

        pageControl?.removeFromSuperview()
        pageControl = nil

        collectionView.setContentOffset(.zero, animated: false)
        collectionLayout.invalidateLayout()
        collectionView.reloadData()

        setupPageControl()
    }

    func setupPageControl() {
        let pageControl = BeanPageControl()
        pageControl.count = cellCount

        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            pageControl.heightAnchor.constraint(equalToConstant: 4),
            pageControl.widthAnchor.constraint(greaterThanOrEqualToConstant: 10)
        ])

        self.pageControl = pageControl
    }

}

// MARK: - Actions

private extension ItemsScrollManagerViewController {

    @objc
    func alignmentValueChanged(_ sender: UISegmentedControl) {
        let allValues: [ItemsScrollManager.CellAlignment] = [.left, .centered, .right]
        cellAlignment = allValues[sender.selectedSegmentIndex]
        resetView()
    }

}
