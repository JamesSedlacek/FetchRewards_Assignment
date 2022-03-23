//
//  DessertCell.swift
//  FetchRewards_Assignment
//
//  Created by James Sedlacek on 3/22/22.
//

import UIKit

class DessertCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    func configure(with meal: Meal) {
        titleLabel.text = meal.title
        
        if let url = URL(string: meal.thumbnailUrl) {
            thumbnailImageView.downloaded(from: url, completion: {
                DispatchQueue.main.async() { [weak self] in
                    self?.loadingSpinner.stopAnimating()
                }
            })
        }
        thumbnailImageView.layer.cornerRadius = 8
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping () -> Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                completion()
                self?.image = image
            }
        }.resume()
    }
}
