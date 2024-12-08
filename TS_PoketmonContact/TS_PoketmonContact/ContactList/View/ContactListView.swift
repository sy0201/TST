//
//  ContactListView.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import UIKit
import SnapKit

final class ContactListView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
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

private extension ContactListView {
    func setupUI() {
        tableView.separatorInset.right = 20
        addSubview(tableView)
    }
    
    func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
