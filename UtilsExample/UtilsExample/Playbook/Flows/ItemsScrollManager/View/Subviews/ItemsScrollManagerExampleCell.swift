//
//  ItemsScrollManagerExampleCell.swift
//  UtilsExample
//
//  Created by Дмитрий Демьянов on 14.08.2023.
//

import UIKit

final class ItemsScrollManagerExampleCell: UICollectionViewCell {

    // MARK: - Constants

    static let identifier = description()

    // MARK: - Private Properties

    private let label = UILabel()

    // MARK: - Initialization

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialState()
    }

    // MARK: - Internal Methods

    func configure(with index: Int) {
        label.text = String(index)
    }

}

// MARK: - Private Methods

private extension ItemsScrollManagerExampleCell {

    func setupInitialState() {
        backgroundColor = .white
        layer.cornerRadius = 16

        label.font = .systemFont(ofSize: 30)

        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
