//
//  ViewController.swift
//  login-screen
//
//  Created by Daniil on 23.04.2023.
//

import UIKit
import BottomSheet

final class LoginViewController: UIViewController {
    // MARK: - Properties
    
    private let consts = Constants()
    
    private lazy var backgroundImage: UIImageView = {
        guard let image = UIImage(named: consts.imageConsts.imageName) else {
            return UIImageView()
        }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = consts.nameLabel.textColor
        label.text = consts.nameLabel.text
        label.font = consts.nameLabel.font
        
        return label
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = consts.signbutton.backgroundColor
        button.titleLabel?.font = consts.signbutton.fontKarlaBold
        button.setTitle(consts.signbutton.text, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(handleShowBottomSheet), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = consts.backgroundColor
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - Methods
    
    @objc
    func handleShowBottomSheet() {
        print("kek")
        presentBottomSheet(viewController: LoginBottomSheetViewController(initialHeight: 600), configuration: .default)
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(signButton)
        view.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        signButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signButton.heightAnchor.constraint(equalToConstant: consts.signbutton.height)
        ])
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Constants

extension LoginViewController {
    struct Constants {
        let imageConsts = ImageConsts()
        let signbutton = SignButtonConsts()
        let nameLabel = NameLabel()
        
        let backgroundColor: UIColor = .systemBackground
        
        struct ImageConsts {
            let imageName = "greens"
        }
        
        struct SignButtonConsts {
            let backgroundColor: UIColor = .systemBackground
            let text = "Sign to your account"
            let fontKarlaBold = UIFont(name: "Karla-Bold", size: 16)
            let fontKarlaExtraBold = UIFont(name: "Karla-ExtraBold", size: 16)
            let height: CGFloat = 75.0
        }
        
        struct NameLabel {
            let text = "AERO"
            let textColor: UIColor = .white
            let font = UIFont(name: "PlayfairDisplay-Bold", size: 36)
        }
    }
}
