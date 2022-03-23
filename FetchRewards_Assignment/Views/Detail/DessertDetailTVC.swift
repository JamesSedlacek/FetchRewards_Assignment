//
//  DessertDetailTVC.swift
//  FetchRewards_Assignment
//
//  Created by James Sedlacek on 3/22/22.
//

import UIKit

class DessertDetailTVC: UITableViewController {
    
    private var vm: DetailVM = DetailVM()
    var dessert: Meal?
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await setupVM()
        }
        setupTV()
        self.title = dessert?.title
    }
    
    // MARK: Setup
    
    private func setupTV() {
        tableView.register(UINib(nibName: "InstructionsCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "InstructionsCell")
        tableView.register(UINib(nibName: "IngredientCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "IngredientCell")
        tableView.dataSource = vm
    }
    
    private func setupVM() async {
        vm.reloadTableViewClosure = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        if let dessert = dessert {
            let loadingVC = LoadingVC(nibName: "LoadingVC", bundle: nil)
            loadingVC.modalPresentationStyle = .overFullScreen
            present(loadingVC, animated: false)
            await vm.fetchDessert(id: dessert.id)
            loadingVC.dismiss(animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 140 : 44
    }
}
