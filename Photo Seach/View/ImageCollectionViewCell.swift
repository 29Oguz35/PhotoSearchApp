//
//  ImageCollectionViewCell.swift
//  Photo Seach
//
//  Created by naruto kurama on 26.04.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "imageCollectionViewCell"
    
    private let imageView : UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    func configure(with urlString : String) {
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil  else { return }
            
            DispatchQueue.main.async {
                let img = UIImage(data: data)
                self?.imageView.image = img
            }

        }.resume()
    }
}
