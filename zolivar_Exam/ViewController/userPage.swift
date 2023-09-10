import UIKit

class userPage: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    
    var userProfile: UserProfile?
    var rewardsList: DataList?
    var rewardItem = [RewardItem]()
    let nameLabel = UILabel()
    let mobileLabel = UILabel()
    let referralCodeLabel = UILabel()
    let userViewModel = userPageViewModel()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rewardItem.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellIdentifier", for: indexPath) as! CollectionViewCell
        // Populate cell's image and description based on your data source
        cell.loadImage(fromURL: URL(string: rewardItem[indexPath.row].image)!)
        cell.descriptionLabel.text = rewardItem[indexPath.row].description
        print("Collection View Data: ")
        print(rewardItem)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("Selected Cell:  \(indexPath.row)")
    }
    // UICollectionView
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Set the scroll direction to horizontal
        layout.minimumInteritemSpacing = 0 // Add spacing between items (adjust as needed)
        // Calculate the item size based on the screen size
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth - 40 // 20 points spacing on both sides
        let itemHeight = itemWidth // Make it square or adjust as needed
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // Configure collectionView properties and register cell class here
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Title"
        // Configure labels
        configureLabels()
        // Configure and add the collectionView
        configureCollectionView()
        userViewModel.getRewards{ result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(ApiResponse.self, from: data)
                    switch loginResponse.status{
                    case 200:
                        
                        DispatchQueue.main.async {
                            self.rewardItem = loginResponse.data.list
                            print(self.rewardItem)
                            self.collectionView.reloadData()
                        }
                    case 404:
                        print("404 Not Found")
                    default: print("Unhandled Status Code")
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            case .failure(let error):
                print("Error fetching rewards: \(error)")
            }
        }
    }

    func parseLists(jsonData: Data) -> DataList? {
        do {
            // Parse JSON data into DataList
            let dataResponse = try JSONDecoder().decode(DataList.self, from: jsonData)
            return dataResponse
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }

    private func configureLabels() {
        // Create a vertical stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center // Center labels vertically
        stackView.spacing = 0
        // Configure label properties (e.g., font, text color, etc.)
        view.backgroundColor = .systemPink
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        nameLabel.text = "Mani Ting"
        mobileLabel.font = UIFont.boldSystemFont(ofSize: 20)
        mobileLabel.textColor = .black
        mobileLabel.text = "9123456789"
        referralCodeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        referralCodeLabel.textColor = .black
        referralCodeLabel.text = "qwe123"
        // Add labels to the stack view
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(mobileLabel)
        stackView.addArrangedSubview(referralCodeLabel)
        // Add the stack view to the view
        view.addSubview(stackView)
        // Set stack view constraints (use Auto Layout)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCellIdentifier")
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: referralCodeLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
