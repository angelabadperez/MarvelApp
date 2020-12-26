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
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    // MARK: - Public API
    
    public func configure() {
        
    }

}
