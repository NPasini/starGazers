//
//  StarGazerTableViewCell.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

import UIKit
//import SDWebImage

class StarGazerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.textColor = UIColor.lightText
        avatarImage.layer.cornerRadius = avatarImage.frame.width/2
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = ""
        avatarImage.image = nil
    }

    func configure(with gazer: StarGazer) {
        nameLabel.text = gazer.name

        if let urlString = gazer.imageURL {
//            avatarImage.sd_setImage(with: imageURL) { [weak self] (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
//                guard error == nil else { return }
//
//                self?.avatarImage.image = image
//            }
        } else {
            avatarImage.image = UIImage()
        }
    }
}
