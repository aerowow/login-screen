//
//  LoginBottomSheetViewController.swift
//  login-screen
//
//  Created by Daniil on 23.04.2023.
//

import UIKit
import SnapKit

final class LoginBottomSheetViewController: UIViewController {
    // MARK: - Subviews
    
    private let consts = Constants()
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    
    private var hasAccount = true
    
    private lazy var headersStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = consts.headersStackViewConsts.spacing
        
        return stackView
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = consts.loginLabel.textLogin
        label.textColor = consts.loginLabel.textColor
        label.font = consts.loginLabel.font
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
       let label = UILabel()
        label.text = consts.subtitleLabel.textSign
        label.textColor = consts.subtitleLabel.textColor
        label.font = consts.subtitleLabel.font
        
        return label
    }()
    
    private lazy var infoFieldsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = consts.infoConsts.commonSpacing
        
        return stackView
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = consts.infoConsts.spacingBetweenSubStackviews
        
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.text = consts.nameLabel.text
        label.textColor = consts.infoConsts.color
        label.font = consts.infoConsts.font
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
       let txtField = UITextField()
        txtField.backgroundColor = consts.infoConsts.textFieldBackgroundColor
        txtField.addLeftPadding(consts.infoConsts.textFieldPadding)
        txtField.textColor = .label
        
        return txtField
    }()
    
    private lazy var emailStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = consts.infoConsts.spacingBetweenSubStackviews
        
        return stackView
    }()
    
    private lazy var emailLabel: UILabel = {
       let label = UILabel()
        label.text = consts.emailLabel.text
        label.textColor = consts.infoConsts.color
        label.font = consts.infoConsts.font
        
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
       let txtField = UITextField()
        txtField.backgroundColor = consts.infoConsts.textFieldBackgroundColor
        txtField.addLeftPadding(consts.infoConsts.textFieldPadding)
        txtField.textColor = .label
        txtField.keyboardType = .emailAddress
        txtField.autocorrectionType = .no
        txtField.autocapitalizationType = .none
        txtField.clearButtonMode = .whileEditing
        
        return txtField
    }()
    
    private lazy var passwordStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = consts.infoConsts.spacingBetweenSubStackviews
        
        return stackView
    }()
    
    private lazy var passwordLabel: UILabel = {
       let label = UILabel()
        label.text = consts.passwordLabel.text
        label.textColor = consts.infoConsts.color
        label.font = consts.infoConsts.font
        
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
       let txtField = UITextField()
        txtField.backgroundColor = consts.infoConsts.textFieldBackgroundColor
        txtField.addLeftPadding(consts.infoConsts.textFieldPadding)
        txtField.textColor = .label
        txtField.isSecureTextEntry = true
        txtField.autocapitalizationType = .none
        
        return txtField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBackground
        button.titleLabel?.font = consts.secondaryButtons.font
        button.setTitle(consts.secondaryButtons.forgotPassLabel, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(
            self,
            action: #selector(showHint),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBackground
        button.titleLabel?.font = consts.secondaryButtons.font
        button.setTitle(consts.secondaryButtons.dontHaveAccLabel, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(
            self,
            action: #selector(registerAccount),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = consts.loginButton.backgroundColor
        button.titleLabel?.font = consts.loginButton.fontKarlaBold
        button.setTitle(consts.loginButton.textLogin, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(
            self,
            action: #selector(loginToAccount),
            for: .touchUpInside
        )
        
        return button
    }()
    
    // MARK: - Properties
    private var currentHeight: CGFloat {
        didSet {
            updatePreferredContentSize()
        }
    }
    
    // MARK: - Init
    
    init(initialHeight: CGFloat) {
        self.currentHeight = initialHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = consts.backgroundColor
        
        nameStackView.isHidden = true
        
        addSubviews()
        setupConstraints()
        updatePreferredContentSize()
        setupGestureRecognizer()
        setupTextField()
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(headersStackView)
        scrollContentView.addSubview(infoFieldsStackView)
        scrollContentView.addSubview(forgotPasswordButton)
        scrollContentView.addSubview(dontHaveAccountButton)
        scrollContentView.addSubview(loginButton)
        
        headersStackView.addArrangedSubview(loginLabel)
        headersStackView.addArrangedSubview(subtitleLabel)
    
        infoFieldsStackView.addArrangedSubview(nameStackView)
        infoFieldsStackView.addArrangedSubview(emailStackView)
        infoFieldsStackView.addArrangedSubview(passwordStackView)
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        
        emailStackView.addArrangedSubview(emailLabel)
        emailStackView.addArrangedSubview(emailTextField)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
    }
    
    private func setupConstraints() {
        let headersInsets = consts.headersStackViewConsts.insets
        let infoFieldsInsets = consts.infoConsts.insets
        let secondaryButtonsInsets = consts.secondaryButtons.secondaryButtonsInsets
        
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.alwaysBounceVertical = true
        
        scrollContentView.snp.makeConstraints {
            $0.edges.width.height.equalTo(scrollView)
        }
        
        headersStackView.snp.makeConstraints {
            $0.top.equalTo(scrollContentView).inset(headersInsets.top)
            $0.leading.equalTo(scrollContentView).inset(headersInsets.left)
            $0.trailing.equalTo(scrollContentView).inset(headersInsets.right)
        }
        
        nameTextField.setHeight(consts.infoConsts.textFieldHeight)
        emailTextField.setHeight(consts.infoConsts.textFieldHeight)
        passwordTextField.setHeight(consts.infoConsts.textFieldHeight)
        
        infoFieldsStackView.snp.makeConstraints {
            $0.top.equalTo(headersStackView.snp.bottom).inset(infoFieldsInsets.top)
            $0.leading.equalTo(scrollContentView).inset(infoFieldsInsets.left)
            $0.trailing.equalTo(scrollContentView).inset(infoFieldsInsets.right)
        }
        
        forgotPasswordButton.snp.makeConstraints {
            $0.top.equalTo(infoFieldsStackView.snp.bottom).inset(secondaryButtonsInsets.top)
            $0.leading.equalTo(scrollContentView).inset(secondaryButtonsInsets.left)
        }
        
        dontHaveAccountButton.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top).inset(secondaryButtonsInsets.bottom)
            $0.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(scrollContentView)
            $0.height.equalTo(consts.loginButton.height)
        }
    }
    
    @objc
    private func loginToAccount() {
        
    }
    
    @objc
    private func showHint() {
        let alert = UIAlertController(
            title: consts.alert.title,
            message: consts.alert.message,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: consts.alert.buttonTitle,
            style: .default)
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    @objc
    private func registerAccount() {
        hasAccount.toggle()
        
        if !hasAccount {
            UIView.animate(withDuration: 0.35) {
                self.loginLabel.text = self.consts.loginLabel.textRegister
                self.subtitleLabel.text = self.consts.subtitleLabel.textCreate
                self.loginButton.setTitle(
                    self.consts.loginButton.textRegister,
                    for: .normal
                )
                self.dontHaveAccountButton.setTitle(
                    self.consts.secondaryButtons.haveAccLabel,
                    for: .normal
                )
                self.nameStackView.isHidden = false
                self.nameStackView.alpha = 1
                self.forgotPasswordButton.alpha = 0
                self.forgotPasswordButton.isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.35) {
                self.loginLabel.text = self.consts.loginLabel.textLogin
                self.subtitleLabel.text = self.consts.subtitleLabel.textSign
                self.loginButton.setTitle(
                    self.consts.loginButton.textLogin,
                    for: .normal
                )
                self.dontHaveAccountButton.setTitle(
                    self.consts.secondaryButtons.dontHaveAccLabel,
                    for: .normal
                )
                self.nameStackView.isHidden = true
                self.nameStackView.alpha = 0
                self.forgotPasswordButton.alpha = 1
                self.forgotPasswordButton.isHidden = false
            }
        }
    }
    
    @objc
    private func dismissKeyboard() {
        scrollView.endEditing(true)
    }
    
    @objc
    private func togglePasswordVisibility(_ sender: UIButton) {
        UIView.transition(
            with: sender,
            duration: 0.3,
            options: .transitionCrossDissolve) {
            sender.isSelected = !sender.isSelected
        }
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        scrollContentView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupTextField() {
        let textFields = [nameTextField, emailTextField, passwordTextField]
        let showHideButton = UIButton(type: .custom)
        let buttonSize = consts.secondaryButtons.showHideButtonSize
        let containerView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: buttonSize + 16,
            height: buttonSize)
        )
        
        for textField in textFields {
            textField.layer.borderWidth = consts.infoConsts.textFieldBorderWidth
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = consts.infoConsts.textFieldCornerRadius
        }
        
        showHideButton.setImage(consts.icons.eyeOff, for: .normal)
        showHideButton.setImage(consts.icons.eye, for: .selected)
        showHideButton.frame = consts.secondaryButtons.showHideButtonFrame
        showHideButton.imageView?.contentMode = .scaleAspectFit
        showHideButton.addTarget(
            self,
            action: #selector(togglePasswordVisibility),
            for: .touchUpInside
        )
        
        containerView.addSubview(showHideButton)
        passwordTextField.rightView = containerView
        passwordTextField.rightViewMode = .always
    }
    
    private func updatePreferredContentSize() {
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: currentHeight
        )
        preferredContentSize = scrollView.contentSize
    }
    
    private func updateContentHeight(newValue: CGFloat) {
        guard newValue >= 200 && newValue < 5000 else { return }
        
        currentHeight = newValue

        let updates = { [self] in
            scrollContentView.snp.updateConstraints {
                $0.height.equalTo(newValue)
            }
            preferredContentSize = CGSize(
                width: UIScreen.main.bounds.width,
                height: newValue
            )
        }
        let canAnimateChanges = viewIfLoaded?.window != nil
        if canAnimateChanges {
            UIView.animate(withDuration: 0.35, animations: updates)
        } else {
            updates()
        }
    }
}

// MARK: - Constants extension
extension LoginBottomSheetViewController {
    struct Constants {
        let loginLabel = LoginLabelConsts()
        let subtitleLabel = SubtitleLabelConsts()
        let nameLabel = NameLabelConsts()
        let emailLabel = EmailLabelConsts()
        let passwordLabel = PasswordLabelConsts()
        let headersStackViewConsts = HeadersStackViewConsts()
        let infoConsts = InfoConsts()
        let secondaryButtons = SecondaryButtons()
        let loginButton = LoginButtonConsts()
        let alert = Alert()
        let icons = Icons()
        
        let backgroundColor: UIColor = .systemBackground
        
        struct HeadersStackViewConsts {
            let spacing: CGFloat = 8
            let insets = UIEdgeInsets(
                top: 50,
                left: 32,
                bottom: 32,
                right: -32
            )
        }
        
        struct LoginLabelConsts {
            let textLogin = "Login"
            let textRegister = "Register"
            let textColor: UIColor = .label
            let font = UIFont(name: "PlayfairDisplay-Bold", size: 24)
        }
        
        struct SubtitleLabelConsts {
            let textSign = "Sign to your account"
            let textCreate = "Create your account"
            
            let textColor: UIColor = .systemGray
            let font = UIFont(name: "Karla-Regular", size: 16)
        }
        
        struct InfoConsts {
            let insets = UIEdgeInsets(
                top: -60,
                left: 32,
                bottom: 32,
                right: 32
            )
            let textFieldBackgroundColor: UIColor = .systemGray6
            let textFieldPadding: CGFloat = 20
            let textFieldHeight: CGFloat = 50
            let textFieldBorderWidth: CGFloat = 0.5
            let textFieldCornerRadius: CGFloat = 5.0
            let commonSpacing: CGFloat = 30
            let spacingBetweenSubStackviews: CGFloat = 10
            let color: UIColor = .systemGray2
            let font = UIFont(
                name: "Karla-Regular",
                size: 14
            ) ?? .systemFont(ofSize: 14)
        }
        
        struct NameLabelConsts {
            let text = "YOUR NAME"
        }
        
        struct EmailLabelConsts {
            let text = "YOUR EMAIL"
        }
        
        struct PasswordLabelConsts {
            let text = "PASSWORD"
        }
        
        struct SecondaryButtons {
            let forgotPassLabel = "Forgot Password?"
            let dontHaveAccLabel = "I don’t have account"
            let haveAccLabel = "I have an account"
            let showHideButtonSize = 20
            let showHideButtonFrame = CGRect(x: 0, y: 0, width: 24, height: 24)
            let secondaryButtonsInsets = UIEdgeInsets(
                top: -32,
                left: 32,
                bottom: -32,
                right: 32
            )
            let font = UIFont(
                name: "Karla-Bold",
                size: 16
            ) ?? .systemFont(ofSize: 16)
        }
        
        struct LoginButtonConsts {
            let backgroundColor = UIColor(
                red: 0.098,
                green: 0.647,
                blue: 0.29,
                alpha: 1
            )
            let textLogin = "Login"
            let textRegister = "Register"
            let fontKarlaBold = UIFont(name: "Karla-Bold", size: 16)
            let fontKarlaExtraBold = UIFont(name: "Karla-ExtraBold", size: 16)
            let height: CGFloat = 75.0
        }
        
        struct Alert {
            let title = "Forgot Password?"
            let message = "We send you new pass in mail."
            let buttonTitle = "OK"
        }
        
        struct Icons {
            let eye = UIImage(named: "eye")
            let eyeOff = UIImage(named: "eye-off")
        }
    }
}

// MARK: - UITextField extension
extension UITextField {
    func addLeftPadding(_ padding: CGFloat) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
    }
    
    func setHeight(_ height: CGFloat) {
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
}
