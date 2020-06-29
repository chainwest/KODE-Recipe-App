//
//  MainScreenTableViewController.swift
//  KODE Recipe App
//
//  Created by Evgeniy on 24.06.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class MainScreenTableViewController: UITableViewController {
    let viewModel: MainScreenViewModel
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindToViewModel()
    }
    
    func setupTableView() {
        self.navigationItem.title = "Recipe List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.rowHeight = 130
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "MainScreenTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        viewModel.getRecipesList()
    }
    
    func bindToViewModel() {
        viewModel.onDidUpdate = { [weak self] in
            self!.tableView.reloadData()
        }
    }

}

extension MainScreenTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MainScreenTableViewCell
        cell.setupCell(viewModel: viewModel, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(uuid: indexPath.row)
    }
}
