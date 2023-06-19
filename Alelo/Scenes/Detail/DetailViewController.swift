import UIKit

protocol DetailDisplayLogic: AnyObject {
    func display(url: String)
    func display(name: String)
    func display(price: NSAttributedString)
    func displayOnSale(isOnSale: Bool)
    func display(sizes: String)
    func display(quantity: Int)
    func presentBagState(_ isEmpty: Bool)
}

class DetailViewController: UIViewController {
    var interactor: DetailBusinessLogic?
    private var router: DetailRouter?
    private var product: Product?
    
    enum Strings {
        static let onSale = "Promoção imperdivel"
        static let add = "Adicionar"
        static let remove = "Remover"
    }
    
    enum Constants {
        enum ImageView {
            static let height: CGFloat = 180
        }
    }
    
    // MARK: Views
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = Fonts.biggestBold
        return label
    }()
    
    private lazy var onSaleLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.onSale
        label.textAlignment = .center
        label.layer.cornerRadius = Spacing.extraSmall
        label.font = Fonts.normalBold
        label.backgroundColor = .red
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var quantityLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.onSale
        label.textAlignment = .center
        label.layer.cornerRadius = Spacing.extraSmall
        label.font = Fonts.normalBold
        label.backgroundColor = .systemGreen
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var sizesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = Fonts.biggestBold
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.buttonSize = .small
        filled.baseBackgroundColor = .systemGreen
        filled.image = UIImage(systemName: "plus.circle.fill")
        filled.imagePlacement = .trailing
        filled.imagePadding = Spacing.small
        let button = UIButton(configuration: filled, primaryAction: UIAction(title: Strings.add, handler: { [weak self] _ in
            self?.addItem()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var removeButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.buttonSize = .small
        filled.baseBackgroundColor = .red
        filled.image = UIImage(systemName: "trash.fill")
        filled.imagePlacement = .trailing
        filled.imagePadding = Spacing.small
        let button = UIButton(configuration: filled, primaryAction: UIAction(title: Strings.remove, handler: { [weak self] _ in
            self?.removeItem()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = Spacing.small
        stackView.axis = .horizontal
        return stackView
    }()

    // MARK: Object lifecycle
    convenience init(product: Product) {
        self.init(nibName: nil, bundle: nil)
        self.product = product
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
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.bagManager = BagManager.shared
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        interactor?.load(product: product)
    }
    
    // MARK: Private methods
    @objc
    private func showBag() {
        router?.routeToBag()
    }
    
    @objc
    private func addItem() {
        interactor?.addItem()
    }
    
    @objc
    private func removeItem() {
        interactor?.removeItem()
    }
}

// MARK: ViewConfiguration
extension DetailViewController: ViewConfiguration {
    
    func buildViewHierarchy() {
        view.addSubview(productImageView)
        view.addSubview(productNameLabel)
        view.addSubview(priceLabel)
        view.addSubview(onSaleLabel)
        view.addSubview(sizesLabel)
        view.addSubview(buttonsStackView)
        view.addSubview(quantityLabel)
        buttonsStackView.addArrangedSubview(removeButton)
        buttonsStackView.addArrangedSubview(addButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: Constants.ImageView.height)
        ])
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor,
                                                  constant: Spacing.normal),
            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: Spacing.normal),
            productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: -Spacing.normal),
        ])
        NSLayoutConstraint.activate([
            onSaleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                             constant: Spacing.normal),
            onSaleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: Spacing.normal)
        ])
        NSLayoutConstraint.activate([
            quantityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: Spacing.normal),
            quantityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant: -Spacing.normal)
        ])
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: Spacing.normal),
            priceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor,
                                            constant: Spacing.normal)
        ])
        NSLayoutConstraint.activate([
            sizesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: Spacing.normal),
            sizesLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,
                                             constant: Spacing.extraSmall)
        ])
        NSLayoutConstraint.activate([
            buttonsStackView.heightAnchor.constraint(equalToConstant: Spacing.huge),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                     constant: -Spacing.normal),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                      constant: Spacing.normal),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: -Spacing.normal),
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .white
        onSaleLabel.sizeToFit()
        let barButtonItemBag = UIBarButtonItem(image: UIImage(systemName: "bag"),
                                               style: .plain,
                                               target: self,
                                               action: #selector(showBag))
        self.navigationItem.rightBarButtonItem = barButtonItemBag
    }
}

// MARK: DetailDisplayLogic
extension DetailViewController: DetailDisplayLogic {
   
    func display(url: String) {
        productImageView.load(url: url)
    }
    
    func display(name: String) {
        productNameLabel.text = name
    }
    
    func display(price: NSAttributedString) {
        priceLabel.attributedText = price
    }
    
    func displayOnSale(isOnSale: Bool) {
        onSaleLabel.isHidden = !isOnSale
    }
    
    func display(sizes: String) {
        sizesLabel.text = sizes
    }
    
    func display(quantity: Int) {
        quantityLabel.text = "🛍️ \(quantity)"
    }
    
    func presentBagState(_ isEmpty: Bool) {
        removeButton.isHidden = isEmpty
        quantityLabel.isHidden = isEmpty
    }
}
