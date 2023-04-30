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
    
    private let contentSizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    
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
        
        view.backgroundColor = .white
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
    
    private func updateContentHeight(newValue: CGFloat) {
        guard newValue >= 200 && newValue < 5000 else { return }
        
        contentSizeLabel.text = "preferredContentHeight = \(newValue)"
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
}
