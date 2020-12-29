//
//  CharactersTableViewController.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 26/12/20.
//

import RxSwift
import RxCocoa
import UIKit

class CharactersTableViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: -
    
    private var viewModel: CharactersTableViewModel!
    
    // MARK: -
    
    private let sortTap = PublishSubject<Void>()
    
    // MARK: -
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Bar
        setupNavigationBar()
        
        // Setup Table View
        setupTableView()
        
        // Initialize View Model
        viewModel = CharactersTableViewModel(sortTap: sortTap, dataManager: ServerFetcher())
        
        // Drive Table View
        viewModel?.charactersDriver
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // Drive Activity Indicator
        viewModel?.isLoadingDriver
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // Drive Table View Visibility
        viewModel?.isLoadingDriver
            .filter { $0 == false }
            .drive(tableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // Drive Sort Desc
        viewModel?.sortDescDriver
            .drive(onNext: { [weak self] sortDesc in
                self?.setSortButton(sortDesc: sortDesc)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - View Methods
    
    private func setupNavigationBar() {
        // Set title, font and style
        title = "MarvelApp"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Bebas-Regular", size: 28.0) ?? UIFont.systemFont(ofSize: 28.0),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        // Set sort button on the right
        setSortButton(sortDesc: false)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !activityIndicator.isAnimating else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height {
            viewModel.fetchData()
        }
    }
    
    @objc func sortButtonTapped(_ sender: Any) {
        guard !activityIndicator.isAnimating else { return } 
        self.tableView.isHidden = true
        self.sortTap.onNext(())
    }
    
    // MARK: - Helper Methods
    
    func setSortButton(sortDesc: Bool) {
        // Calculate image name based on sort state
        let imageName: String = {
            if sortDesc {
                return "sort_asc"
            } else {
                return "sort_desc"
            }
        }()
        
        // Set right bar button
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(sortButtonTapped(_:))), animated: true)
    }
    
}

extension CharactersTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterTableViewCell.self), for: indexPath) as? CharacterTableViewCell else {
            fatalError("Unable to Dequeue Character Table View Cell")
        }
        
        // Configure Table View Cell
        if let viewModel = viewModel?.viewModelForCharacter(at: indexPath.row) {
            cell.configure(withViewModel: viewModel)
        }
        
        return cell
    }
}


