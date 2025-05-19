//
//  EmptyTVCell.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/12/24.
//

import UIKit
import SnapKit

final class EmptyTVCell: UITableViewCell, ReuseIdentifying {
    lazy var emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var emptyImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil.circle")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var emptyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .lightGray
        label.text = "연락처를 추가해주세요."
        return label
    }()
    
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

private extension EmptyTVCell {
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        addSubview(emptyView)
        emptyView.addSubViews([emptyImg, emptyLabel])
    }
    
    func setupConstraint() {
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyImg.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.top).offset(100)
            make.centerX.equalTo(emptyView.snp.centerX)
            make.width.height.equalTo(150)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImg.snp.bottom).offset(20)
            make.centerX.equalTo(emptyImg.snp.centerX)
        }
    }
}
