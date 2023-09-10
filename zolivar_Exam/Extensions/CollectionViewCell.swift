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
            // You can use a library like AlamofireImage or URLSession to load the image from the URL
            // Here, we'll use URLSession for simplicity
            URLSession.shared.dataTask(with: imageURL) { [weak self] (data, _, error) in
                guard let data = data, error == nil else {
                    // Handle the error, e.g., show a placeholder image or log an error message
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
    
    // Image view
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        // Configure imageView properties (e.g., content mode, background color, etc.)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.sizeToFit()
        return imageView
    }()

    // Description label
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        // Configure label properties (e.g., font, text color, alignment, etc.)
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
            // Add and configure the image view
            contentView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 200) // Adjust the height as needed
            ])
            // Add and configure the description label
            contentView.addSubview(descriptionLabel)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.layer.borderColor = UIColor.black.cgColor
            contentView.layer.borderWidth = 3
            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor), // Add spacing between image and label
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
}
