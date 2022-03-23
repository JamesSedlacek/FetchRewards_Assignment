//
//  DessertsVC.swift
//  FetchRewards_Assignment
//
//  Created by James Sedlacek on 3/22/22.
//

import UIKit

class DessertsTVC: UITableViewController {
    
    // MARK: Properties
    
    private let vm = DessertVM()
    private var selectedDessert: Meal?

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        Task {
            await setupVM()
        }
    }
    
    // MARK: Setup
    
    private func setupTV() {
        tableView.register(UINib(nibName: "DessertCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "DessertCell")
        tableView.dataSource = vm
    }
    
    private func setupVM() async {
        vm.reloadTableViewClosure = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        await vm.fetchDesserts()
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DessertDetailTVC {
            dest.dessert = selectedDessert
        }
    }
}

// MARK: Delegate

extension DessertsTVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDessert = vm.getDessert(for: indexPath.row)
        performSegue(withIdentifier: "SegueToDetail", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
