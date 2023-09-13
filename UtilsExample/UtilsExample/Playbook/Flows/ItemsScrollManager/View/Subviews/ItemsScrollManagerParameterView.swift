//
//  ItemsScrollManagerParameterView.swift
//  UtilsExample
//
//  Created by Дмитрий Демьянов on 14.08.2023.
//

import UIKit

final class ItemsScrollManagerParameterView: UIView {

    // MARK: - Nested Types

    struct Model {
        let title: String
        let minValue: Int
        let maxValue: Int
        let initialValue: Int
    }

    // MARK: - Properties

    var onValueChanged: ((Int) -> Void)?

    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private let slider = UISlider()
    private let valueLabel = UILabel()

    private var previousValue: Int?

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

    func configure(with model: Model) {
        titleLabel.text = model.title
        slider.minimumValue = Float(model.minValue)
        slider.maximumValue = Float(model.maxValue)
        slider.value = Float(model.initialValue)
        updateValueLabel(with: model.initialValue)
    }

}

// MARK: - Private Methods

private extension ItemsScrollManagerParameterView {

    func setupInitialState() {
        setupContainer()
        setupTitleLabel()
        setupSlider()
        setupValueLabel()
    }

    func setupContainer() {
        let containerView = UIStackView()
        containerView.axis = .horizontal
        containerView.spacing = 10

        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(slider)
        containerView.addArrangedSubview(valueLabel)
    }

    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupSlider() {
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)

        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }

    func setupValueLabel() {
        valueLabel.textAlignment = .right

        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.widthAnchor.constraint(equalToConstant: 48).isActive = true
    }

    func updateValueLabel(with value: Int) {
        valueLabel.text = String(value)
    }

}

// MARK: - Actions

private extension ItemsScrollManagerParameterView {

    @objc
    func sliderValueChanged() {
        let value = Int(slider.value.rounded())
        guard value != previousValue else {
            return
        }

        previousValue = value
        updateValueLabel(with: value)
        onValueChanged?(value)
    }

}
