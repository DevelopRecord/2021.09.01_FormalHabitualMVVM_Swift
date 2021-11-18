//
//  ChartController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//
// 다양한 습관 리스트들을 만들어 놓고(테이블뷰나 컬렉션뷰) 검색하는 방향으로 가면 어떨까

import UIKit

private let reuseIdentifier = "ChartCell"

class ChartController: UITableViewController {
    
    // MARK: Lifecycle
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
    }
    
    // MARK: Helper
    
    func configureTableView() {
        view.backgroundColor = .white
        
        tableView.register(ChartCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 70
        
//        navigationController?.navigationBar.isHidden = true
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

// MARK: UITableViewDataSource

extension ChartController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ChartCell
        return cell
    }
}

// MARK: UISearchResultsUpdating

extension ChartController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
