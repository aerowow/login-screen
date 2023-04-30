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
    
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private let consts = Constants()
    
    private lazy var headersStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = consts.headersStackViewConsts.spacing
        
        return stackView
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = consts.loginLabel.text
        label.textColor = consts.loginLabel.textColor
        label.font = consts.loginLabel.font
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
       let label = UILabel()
        label.text = consts.subtitleLabel.text
        label.textColor = consts.subtitleLabel.textColor
        label.font = consts.subtitleLabel.font
        
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = consts.loginButton.backgroundColor
        button.titleLabel?.font = consts.loginButton.fontKarlaBold
        button.setTitle(consts.loginButton.text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(
            self,
            action: #selector(loginToAccount),
            for: .touchUpInside
        )
        
        return button
    }()
    
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
        addSubviews()
        setupConstraints()
        updatePreferredContentSize()
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(loginButton)
        scrollContentView.addSubview(headersStackView)
        
        headersStackView.addArrangedSubview(loginLabel)
        headersStackView.addArrangedSubview(subtitleLabel)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.alwaysBounceVertical = true
        
        scrollContentView.snp.makeConstraints {
            $0.edges.width.height.equalTo(scrollView)
        }
        
        headersStackView.snp.makeConstraints {
            $0.top.equalTo(scrollContentView).inset(50)
            $0.leading.trailing.equalTo(scrollContentView).inset(32)
            
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(scrollContentView)
            $0.height.equalTo(consts.loginButton.height)
        }
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
            UIView.animate(withDuration: 0.25, animations: updates)
        } else {
            updates()
        }
    }
    
    @objc
    private func loginToAccount() {
        
    }
}

extension LoginBottomSheetViewController {
    struct Constants {
        let loginButton = LoginButtonConsts()
        let headersStackViewConsts = HeadersStackViewConsts()
        let loginLabel = LoginLabelConsts()
        let subtitleLabel = SubtitleLabelConsts()
        
        let backgroundColor: UIColor = .systemBackground
        
        struct LoginButtonConsts {
            let backgroundColor = UIColor(red: 0.098, green: 0.647, blue: 0.29, alpha: 1)
            let text = "Login"
            let fontKarlaBold = UIFont(name: "Karla-Bold", size: 16)
            let fontKarlaExtraBold = UIFont(name: "Karla-ExtraBold", size: 16)
            let height: CGFloat = 75.0
        }
        
        struct HeadersStackViewConsts {
            let spacing: CGFloat = 8
        }
        
        struct LoginLabelConsts {
            let text = "Login"
            let textColor: UIColor = .label
            let font = UIFont(name: "PlayfairDisplay-Bold", size: 24)
        }
        
        struct SubtitleLabelConsts {
            let text = "Sign to your account"
            let textColor: UIColor = .systemGray
            let font = UIFont(name: "Karla-Regular", size: 16)
        }
    }
}
