//
//  RepositorySelectionViewController.swift
//  starGazers
//
//  Created by nicolo.pasini on 11/02/25.
//

import UIKit

class RepositorySelectionViewController: UIViewController {
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var repoDetailsView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var repoNameTextField: UITextField!
    @IBOutlet weak var repoOwnerTextField: UITextField!
    
    private let presenter: RepositorySelectionPresenterProtocol

    private var activeTextField: UITextField?
    
    @IBAction func submitRepoDetails() {
        activeTextField?.resignFirstResponder()
        presenter.didTapOnConfirmButton()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repoNameTextField.delegate = self
        repoOwnerTextField.delegate = self
        
        setupLayout()
        registerForKeyboardNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotification()
    }
    
    // MARK: Intializers
    
    init?(coder: NSCoder, presenter: RepositorySelectionPresenterProtocol) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private Methods

private extension RepositorySelectionViewController {
    enum Constant {
        static let cornerRadius: CGFloat = 20
    }
    
    func setupLayout() {
        confirmButton.layer.cornerRadius = Constant.cornerRadius
        repoDetailsView.layer.cornerRadius = Constant.cornerRadius
    }
    
    private func saveInsertedData(in textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField == repoNameTextField {
            presenter.setRepositoryName(text)
        }
        
        if textField == repoOwnerTextField {
            presenter.setRepositoryOwner(text)
        }
    }
}

// MARK: TextField Delegate

extension RepositorySelectionViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveInsertedData(in: textField)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveInsertedData(in: textField)
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Keyboard

private extension RepositorySelectionViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        let notificationInfo = notification.userInfo
        if let keyboardSize = notificationInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
            
            scrollToDisplayHiddenTextFieldIfNeeded(keyboardSize: keyboardSize)
        }
    }
    
    @objc func keyboardWillHide() {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    func scrollToDisplayHiddenTextFieldIfNeeded(keyboardSize: CGRect) {
        var screenFrame = view.frame
        screenFrame.size.height -= keyboardSize.height;
        if let activeField = activeTextField, !screenFrame.contains(activeField.frame.origin) {
            scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
}
