//
//  LoginViewController.swift
//  AuthKit
//
//  Created by Mark Daigneault on 2/14/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import RxSwift
import Intrepid

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    lazy var orderedTextFields: [UITextField] = [self.emailTextField, self.passwordTextField]

    let viewModel: LoginViewModel

    private let bag = DisposeBag()

    // MARK: - Lifecycle

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupObservers()
    }

    // MARK: - Setup

    func setupTextFields() {
        for textField in orderedTextFields {
            textField.delegate = self
        }

        emailTextField.placeholder = "Email"
        emailTextField.returnKeyType = .next

        passwordTextField.placeholder = "Password"
        passwordTextField.returnKeyType = .go
    }

    func setupObservers() {
        emailTextField.rx.text <-> viewModel.email >>> bag
        passwordTextField.rx.text <-> viewModel.password >>> bag
        submitButton.rx.isEnabled <- viewModel.isSubmitButtonEnabled >>> bag
    }

    // MARK: - Responder Chain

    func selectNextTextFieldOrComplete(currentTextField: UITextField) {
        if currentTextField == orderedTextFields.last {
            attemptLogIn()
        } else if let index = orderedTextFields.index(of: currentTextField) {
            let nextIndex = index + 1
            let nextTextField = orderedTextFields[nextIndex]
            nextTextField.becomeFirstResponder()
        }
    }

    func attemptLogIn() {
        viewModel.attemptLogIn { result in
            switch result {
            case .success:
                // TODO: handle success
                return
            case .failure(let error):
                // TODO: handle error
                return
            }
        }
    }

    // MARK: - Actions

    @IBAction func textFieldEditingDidEndOnExit(_ sender: UITextField) {
        selectNextTextFieldOrComplete(currentTextField: sender)
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        attemptLogIn()
    }
}
