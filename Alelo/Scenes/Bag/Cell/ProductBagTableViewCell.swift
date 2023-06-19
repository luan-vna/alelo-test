import UIKit

protocol ProductBagTableViewCellDelegate: AnyObject {
    
    func addItem(_ product: Product)
    func removeItem(_ product: Product)
}

class ProductBagTableViewCell: UITableViewCell {
    
    static var identifier = "ProductBagTableViewCell"
    
    weak var delegate: ProductBagTableViewCellDelegate?
    
    enum Strings {
        static let add = "Adicionar"
        static let remove = "Remover"
    }
    
    var item: BagItem? {
        didSet {
            updateData()
        }
    }
    
    // MARK: Views
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = Fonts.bigBold
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
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()

    // MARK: Object lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Private methods
    private func updateData() {
        productImageView.load(url: item?.product.image)
        productNameLabel.text = item?.product.name
        priceLabel.text = "x\(item?.quantity ?? 0) - \(item?.total.toCurrency() ?? "")"
    }
    
    private func addItem() {
        guard let product = item?.product else {
            return
        }
        delegate?.addItem(product)
    }
    
    private func removeItem() {
        guard let product = item?.product else {
            return
        }
        delegate?.removeItem(product)
    }
}

// MARK: ViewConfiguration
extension ProductBagTableViewCell: ViewConfiguration {
    
    func buildViewHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(labelsStackView)
        contentView.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(removeButton)
        buttonsStackView.addArrangedSubview(addButton)
        labelsStackView.addArrangedSubview(productNameLabel)
        labelsStackView.addArrangedSubview(priceLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: Spacing.huge),
            productImageView.widthAnchor.constraint(equalToConstant: Spacing.huge),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: Spacing.normal),
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor,
                                                     constant: Spacing.normal),
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                   constant: -Spacing.normal),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.small),
        ])
    }
    
    func configureViews() {
        selectionStyle = .none
    }
}
