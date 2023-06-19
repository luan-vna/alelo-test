import UIKit

protocol BagDisplayLogic: AnyObject {
    func displayItems(items: [BagItem])
    func displayTotal(total: String)
    func presentEmptyState()
}

class BagViewController: UIViewController {
    var interactor: BagBusinessLogic?
    private var items: [BagItem] = []
    
    enum Strings {
        static let title = "Seu carrinho"
        static let empty = "Nenhum item no carrinho"
    }
    
    // MARK: Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductBagTableViewCell.self, forCellReuseIdentifier: ProductBagTableViewCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = 130
        return tableView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = Fonts.bigBold
        label.text = Strings.empty
        return label
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = Fonts.hugeBold
        return label
    }()
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = BagInteractor()
        let presenter = BagPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.bagManager = BagManager.shared
        presenter.viewController = viewController
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadBag()
        buildLayout()
    }
}

// MARK: ViewConfiguration
extension BagViewController: ViewConfiguration {
    
    func buildViewHierarchy() {
        view.addSubview(emptyLabel)
        view.addSubview(tableView)
        view.addSubview(totalLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalLabel.topAnchor,
                                              constant: Spacing.normal)
        ])
        NSLayoutConstraint.activate([
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Spacing.normal),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -Spacing.normal),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -Spacing.big),
            totalLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .white
        title = Strings.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: BagDisplayLogic
extension BagViewController: BagDisplayLogic {
    
    func displayItems(items: [BagItem]) {
        self.items = items
        tableView.reloadData()
    }
    
    func displayTotal(total: String) {
        totalLabel.text = total
    }
    
    func presentEmptyState() {
        emptyLabel.alpha = 1
        tableView.alpha = 0
        totalLabel.alpha = 0
    }
}

// MARK: UITableViewDataSource
extension BagViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductBagTableViewCell.identifier) as? ProductBagTableViewCell else {
            return UITableViewCell()
        }
        cell.item = items[indexPath.row]
        cell.delegate = self
        return cell
    }
}

// MARK: ProductBagTableViewCellDelegate
extension BagViewController: ProductBagTableViewCellDelegate {
    
    func addItem(_ product: Product) {
        interactor?.addItem(product: product)
    }
    
    func removeItem(_ product: Product) {
        interactor?.removeItem(product: product)
    }
}
