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
        
        addSubviews()
        setupConstraints()
        updatePreferredContentSize()
    }
    
    // MARK: - Methods
    private func updatePreferredContentSize() {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
            height: currentHeight)
        preferredContentSize = scrollView.contentSize
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.alwaysBounceVertical = true
    }
    
}
