//
//  ContactListTVCell.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import UIKit
import SnapKit

final class ContactListTVCell: UITableViewCell, ReuseIdentifying {
    let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    lazy var profileImg: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CGColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.text = "name"
        return label
    }()
    
    var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.text = "010-1234-1234"
        return label
    }()
    
    let lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        return lineView
    }()
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        profileImg.layer.cornerRadius = profileImg.bounds.width / 2
//        profileImg.layer.masksToBounds = true
//    }
    
    
    override func draw(_ rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.bounds.width / 2
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Private setup UI Methods

private extension ContactListTVCell {
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        addSubViews([profileStackView, 
                     phoneNumberLabel,
                     lineView])
        profileStackView.addSubViews([profileImg, nameLabel])
    }
    
    func setupConstraint() {
        profileStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImg.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImg.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
