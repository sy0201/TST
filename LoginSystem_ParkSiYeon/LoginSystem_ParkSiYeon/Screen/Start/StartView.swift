//
//  StartView.swift
//  LoginSystem_ParkSiYeon
//
//  Created by siyeon park on 3/14/25.
//

import UIKit
import SnapKit

final class StartView: UIView {
    let baseView = UIView()

    var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.primaryDarkGray, for: .normal)
        button.backgroundColor = .backgroundLightGray
        
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

private extension StartView {
    func setupUI() {
        baseView.backgroundColor = .white
        addSubViews([baseView, startButton])
    }
    
    func setupConstraint() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(baseView).inset(60)
            make.centerY.equalTo(baseView)
            make.height.equalTo(60)
        }
    }
}
