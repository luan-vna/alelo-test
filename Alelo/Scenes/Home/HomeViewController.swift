import UIKit

protocol HomeDisplayLogic: AnyObject {
    func presentAllCatalog(products: [Product])
    func presentError()
    func presentLoading(isLoading: Bool)
}

class HomeViewController: UIViewController {
    private var interactor: HomeBusinessLogic?
    private var router: HomeRoutingLogic?
    private var products: [Product] = []
    
    enum Strings {
        static let title = "Nosso catálogo"
    }
    
    // MARK: Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        return tableView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .large
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    // MARK: Object lifecycle
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let womeWorker = HomeWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = womeWorker
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        loadData()
    }
    
    // MARK: Private Methods
    private func loadData() {
        interactor?.getAll()
    }
    
    @objc
    private func showBag() {
        router?.routeToBag()
    }
    
    @objc
    private func toggleOnSale() {
        interactor?.toggleOnSale()
    }
}

// MARK: HomeDisplayLogic
extension HomeViewController: HomeDisplayLogic {
    func presentAllCatalog(products: [Product]) {
        self.products = products
        tableView.reloadData()
    }
    
    func presentError() {
        router?.routeToError { [weak self] in
            self?.interactor?.getAll()
        }
    }
    
    func presentLoading(isLoading: Bool) {
        if isLoading {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}

// MARK: ViewConfiguration
extension HomeViewController: ViewConfiguration {
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureViews() {
        let barButtonItemBag = UIBarButtonItem(image: UIImage(systemName: "bag"),
                                               style: .plain,
                                               target: self,
                                               action: #selector(showBag))
        let barButtonItemOnSale = UIBarButtonItem(image: UIImage(systemName: "flame"),
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(toggleOnSale))
        self.navigationItem.rightBarButtonItems = [barButtonItemBag, barButtonItemOnSale]
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Strings.title
    }
}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        router?.routeTo(product: product)
    }
}

// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        cell.product = products[indexPath.row]
        return cell
    }
}
