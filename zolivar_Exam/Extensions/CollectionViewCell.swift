//
//  CollectionViewCell.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/9/23.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {

    func loadImage(fromURL imageURL: URL) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] (data, _, error) in
                guard let data = data, error == nil else {
                    print("Error loading image: \(error?.localizedDescription ?? "Unknown Error")")
                    return
                }

                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                        
                    }
                }
            }.resume()
        }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .black
        imageView.sizeToFit()
        return imageView
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()

    override init(frame: CGRect) {
            super.init(frame: frame)
            configureUI()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            configureUI()
        }

        private func configureUI() {
            contentView.addSubview(imageView)
            imageView.layer.cornerRadius = 10
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 150)
            ])
            contentView.addSubview(descriptionLabel)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.layer.borderColor = UIColor.black.cgColor
            contentView.layer.borderWidth = 0.5
            contentView.layer.cornerRadius = 10


            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
                descriptionLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 5),
                descriptionLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)

            ])
        }
}
