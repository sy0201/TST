//
//  ContactListViewController.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import UIKit

final class ContactListViewController: UIViewController {
    let contactListView = ContactListView()
    
    
    override func loadView() {
        super.loadView()
        view = contactListView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        // UINavigationBarAppearance 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명한 기본 배경 설정
        appearance.backgroundColor = .white        // 원하는 배경색으로 설정
        appearance.shadowColor = nil               // 밑줄(쉐도우) 제거
        appearance.shadowImage = UIImage()         // 쉐도우 이미지 제거
        
        // 네비게이션 바에 appearance 적용
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 오른쪽 바 버튼 설정
        let navRightItem = UIBarButtonItem(title: "추가",
                                           style: .plain,
                                           target: self,
                                           action: #selector(addButtonTapped))
        navRightItem.tintColor = .gray
        navigationItem.rightBarButtonItem = navRightItem
        navigationItem.title = "친구 목록"
    }
    
    @objc func addButtonTapped() {
        print("추가버튼 탭")
    }
}

// MARK: - Private Method

private extension ContactListViewController {
    func setupTableView() {
        contactListView.tableView.dataSource = self
        contactListView.tableView.delegate = self
        
        // 셀 연결
        contactListView.tableView.register(ContactListTVCell.self, forCellReuseIdentifier: ContactListTVCell.reuseIdentifier)
    }
}

// MARK: - Tableview Method

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactListTVCell.reuseIdentifier, for: indexPath) as? ContactListTVCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
