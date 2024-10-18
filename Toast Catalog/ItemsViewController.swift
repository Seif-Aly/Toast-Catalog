import UIKit

class ItemsViewController: UITableViewController {

    private lazy var dataSource = makeDataSource()
    private let networkClient = NetworkClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.reuseIdentifier)
        tableView.dataSource = dataSource
        
        fetching()
    }
    
    private func fetching() {
            networkClient.getItems { [weak self] result in
                switch result {
                case .success(let items):
                    DispatchQueue.main.async {
                        self?.update(with: items)
                    }
                case .failure:
                    print("Failed to fetch")
                }
            }
        }

    func makeDataSource() -> UITableViewDiffableDataSource<Int, Item> {
        UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ItemTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as? ItemTableViewCell

                cell?.nameLabel.text = item.name
                cell?.priceLabel.text = "\(item.price) €"
                cell?.setIcon(with: item.id)
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.timeStyle = .short
                if let date = ISO8601DateFormatter().date(from: item.last_sold)
                {
                    cell?.dateLabel.text = formatter.string(from: date)
                }

                return cell
            }
        )
    }

    func update(with items: [Item], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }

}
