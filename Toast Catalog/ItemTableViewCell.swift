import UIKit

class ItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "item_cell"

    var iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(dateLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 30),
            iconView.widthAnchor.constraint(equalToConstant: 30),
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor)
        ])
    }
    
    func setIcon(with number: Int) {
        iconView.image = generateCircle(number)
    }

    private func generateCircle(_ number: Int) -> UIImage? {
        let size = CGSize(width: 30, height: 30)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let circleRect = CGRect(origin: .zero, size: size)
            let cgContext = context.cgContext
            cgContext.setFillColor(UIColor.black.cgColor)
            cgContext.fillEllipse(in: circleRect)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.white
            ]

            let numberString = "\(number)" as NSString
            let textSize = numberString.size(withAttributes: attributes)
            let textRect = CGRect(
                x: (circleRect.width - textSize.width) / 2,
                y: (circleRect.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
            )

            numberString.draw(in: textRect, withAttributes: attributes)
        }
    }
}
