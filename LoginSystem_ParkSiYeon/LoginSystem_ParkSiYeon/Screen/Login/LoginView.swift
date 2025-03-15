//
//  LoginView.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/15/25.
//

import UIKit
import SnapKit

final class LoginView: UIView {
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private let baseView = UIView()
    
    var nicknameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .primaryDarkGray
        return label
    }()
    
    var descriptionLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .primaryDarkGray
        label.text = "님 환영합니다."
        return label
    }()
    
    var logoutButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.primaryDarkGray, for: .normal)
        button.backgroundColor = .backgroundLightGray
        
        return button
    }()
    
    var withdrawButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.borderGray, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private setupUI Method

private extension LoginView {
    func setupUI() {
        self.backgroundColor = .white
        baseView.backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(baseView)
        baseView.addSubViews([nicknameLabel,
                              descriptionLabel,
                              logoutButton,
                              withdrawButton])
    }
    
    func setupConstraint() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        baseView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(70)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalTo(logoutButton.snp.centerX)
            make.height.equalTo(40)
        }
    }
}
