//
//  KeyboardPresentableViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class KeyboardPresentableViewController: UIViewController, KeyboardObservable {

    // MARK: - IBOutlets

    @IBOutlet private weak var subTitle: UILabel!
    @IBOutlet private weak var someField: UITextField!

    // MARK: - Properties

    var output: KeyboardPresentableViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        // Для подписки на нотификации появления/сокрытия клавиатуры необходимо вызывать:
        subscribeOnKeyboardNotifications()
        configureGesture()
        output?.viewLoaded()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Для отписывания от нотификаций появления/сокрытия клавиатуры необходимо вызывать:
        unsubscribeFromKeyboardNotifications()
    }

}

// MARK: - KeyboardPresentableViewInput

extension KeyboardPresentableViewController: KeyboardPresentableViewInput {

    func setupInitialState() {
        subTitle.text = "Keyboard сокрыт"
    }

}

// MARK: - CommonKeyboardPresentable

extension KeyboardPresentableViewController: CommonKeyboardPresentable {

    func keyboardWillBeShown(keyboardHeight: CGFloat, duration: TimeInterval) {
        subTitle.text = "Keyboard показан"
    }

    func keyboardWillBeHidden(duration: TimeInterval) {
        subTitle.text = "Keyboard сокрыт"
    }

}

// MARK: - Private methods

private extension KeyboardPresentableViewController {

    func configureGesture() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

}
