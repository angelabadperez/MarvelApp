//
//  CharactersTableViewController.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 26/12/20.
//

import UIKit

class CharactersTableViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CharactersTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
