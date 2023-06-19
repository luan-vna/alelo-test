import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static var identifier = "ProductTableViewCell"
    
    enum Strings {
        static let onSale = "Promoção imperdivel"
    }
    
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

    var product: Product? {
        didSet {
            updateData()
        }
    }
    
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

    private func updateData() {
        productImageView.load(url: product?.image)
        productNameLabel.text = product?.name
        onSaleLabel.isHidden = product?.onSale == false
        priceLabel.attributedText = product?.priceAttributed()
    }
}

extension ProductTableViewCell: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(productImageView)
        addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(productNameLabel)
        labelsStackView.addArrangedSubview(priceLabel)
        addSubview(onSaleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: Spacing.huggest),
            productImageView.widthAnchor.constraint(equalToConstant: Spacing.huggest),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: Spacing.normal),
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor,
                                                     constant: Spacing.normal),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                      constant: -Spacing.normal),
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor,
                                                     constant: -Spacing.biggest)
        ])
        NSLayoutConstraint.activate([
            onSaleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor,
                                                 constant: Spacing.normal),
            onSaleLabel.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor,
                                             constant: Spacing.extraSmall)
        ])
    }
    
    func configureViews() {
        onSaleLabel.sizeToFit()
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}
