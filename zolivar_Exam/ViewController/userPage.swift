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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("SELECTED \(indexPath.row)")

        DispatchQueue.main.async {
            var viewModel = rewardPageViewModel(imageURL: self.rewardItem[indexPath.row].image, name: self.rewardItem[indexPath.row].name, description: self.rewardItem[indexPath.row].description)
            let vc = rewardPage(viewModel: viewModel)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true,completion: nil)
        }

        
    }

    // UICollectionView
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth - 20
        layout.itemSize = CGSize(width: itemWidth, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
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




    private func configureLabels() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0
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
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(mobileLabel)
        stackView.addArrangedSubview(referralCodeLabel)
        view.addSubview(stackView)
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
            collectionView.topAnchor.constraint(equalTo: referralCodeLabel.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
