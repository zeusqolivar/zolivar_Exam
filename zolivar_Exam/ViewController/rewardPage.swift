//
//  rewardPage.swift
//  zolivar_Exam
//
//  Created by zolivar on 9/11/23.
//
import UIKit

class rewardPage: UIViewController {

    var viewModel: rewardPageViewModel? // Replace with your view model type if needed

    init(viewModel: rewardPageViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    // Lazy variables
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white


        // Create and configure the back button
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews to the view
        view.addSubview(backButton)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)

        // Set up constraints
        NSLayoutConstraint.activate([
            // Back button constraints
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            // Image view constraints
            imageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120), // Adjust width as needed
            imageView.heightAnchor.constraint(equalToConstant: 120), // Adjust height as needed

            // Name label constraints
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Description label constraints
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        // Load and set the image from a URL
        
        if let imageUrl = viewModel?.imageURL, let url = URL(string: imageUrl) {
            loadImage(fromURL: url)
        }
        nameLabel.text = viewModel?.name
        descriptionLabel.text = viewModel?.description
        print("WHERE DATA NAME: \(viewModel?.name)")

    }

    // Function to load and set an image from a URL
    func loadImage(fromURL url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error loading image: \(error)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }

            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
    }

    // Function to handle back button tap
    @objc func backButtonTapped() {
        // Dismiss the current view controller
        dismiss(animated: true)
    }
}

