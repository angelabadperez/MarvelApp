//
//  CharacterTableViewCell.swift
//  MarvelApp
//
//  Created by Ángel Abad Pérez on 26/12/20.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    // MARK: - Public API
    
    public func configure(withViewModel viewModel: CharacterPresentable) {
        // Set name
        nameLabel.text = viewModel.name
        
        // Set description. If none is avaible, set "-"
        let description: String = {
            if viewModel.description.isEmpty || viewModel.description.count == 0 {
                return "-"
            }
            return viewModel.description
        }()
        
        descriptionLabel.text = description
        
        // Download image
        thumbnailImageView.loadImage(image: viewModel.image, size: .square, using: viewModel.dataManager)
    }

}
