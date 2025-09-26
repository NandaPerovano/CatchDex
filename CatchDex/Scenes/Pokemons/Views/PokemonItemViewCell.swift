//
//  PokemonItemViewCell.swift
//  CatchDex
//
//  Created by Fernanda Perovano on 25/09/25.
//

import UIKit
import Kingfisher

final class PokemonItemViewCell: UITableViewCell {
    
    // MARK: - View Components
    
    private let containerView = UIView()
    
    private let identifierLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private let imageContainer = UIView()
    
    private let imagePokemonView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    private let tagsView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return stack
    }()
    
    private lazy var detailStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [identifierLabel, nameLabel, tagsView])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 12
        return stack
    }()

    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [detailStackView, imageContainer])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    private let avatarDiameter: CGFloat = {
        return UIDevice.current.userInterfaceIdiom == .phone ? 100 : 140
    }()
    private let avatarPadding: CGFloat = 8
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func configureView() {
        addSubviews()
        constrainSubviews()
        selectionStyle = .none
        separatorInset = .zero
        containerView.layer.cornerRadius = 16
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    // MARK: - Overrides
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        imageContainer.addSubview(imagePokemonView)
    }
    
    private func constrainSubviews() {
        containerView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            topConstant: 20,
            leadingConstant: 20,
            bottomConstant: 20,
            trailingConstant: 20
        )
        
        mainStackView.anchor(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            bottom: containerView.bottomAnchor,
            trailing: containerView.trailingAnchor,
            topConstant: 20,
            leadingConstant: 20,
            bottomConstant: 20,
            trailingConstant: 20
        )
        
        imageContainer.anchor(widthConstant: avatarDiameter, heightConstant: avatarDiameter)
        imageContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4).isActive = true
    
        imagePokemonView.anchor(
            top: imageContainer.topAnchor,
            leading: imageContainer.leadingAnchor,
            bottom: imageContainer.bottomAnchor,
            trailing: imageContainer.trailingAnchor,
            topConstant: avatarPadding,
            leadingConstant: avatarPadding,
            bottomConstant: avatarPadding,
            trailingConstant: avatarPadding
        )
        
        imageContainer.setContentHuggingPriority(.required, for: .horizontal)
        imageContainer.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageContainer.setContentHuggingPriority(.required, for: .vertical)
        imageContainer.setContentCompressionResistancePriority(.required, for: .vertical)
        
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        identifierLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    
    // MARK: - Public methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePokemonView.kf.cancelDownloadTask()
        imagePokemonView.image = UIImage(named: "placeholder")
        identifierLabel.text = nil
        nameLabel.text = nil
       
        tagsView.arrangedSubviews.forEach { view in
            tagsView.removeArrangedSubview(view); view.removeFromSuperview()
        }
    }
    
    func setupViewData(_ viewData: PokemonsScene.ViewData) {
        let name = viewData.name.prefix(1).uppercased() + viewData.name.dropFirst()
        identifierLabel.text = viewData.identifier
        nameLabel.text = name
        containerView.backgroundColor = viewData.backgroundColor
        
        let targetPoints = CGSize(
            width: avatarDiameter - 2*avatarPadding,
            height: avatarDiameter - 2*avatarPadding
        )
       
       // let trim = TrimTransparentProcessor(threshold: 1)
        //let down = DownsamplingImageProcessor(size: targetPoints)
       // let processor = trim.append(another: down)
        
        imagePokemonView.kf.setImage(
            with: viewData.imageURL,
            placeholder: UIImage(named: "placeholder"),
            options: [
               // .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage,
                .transition(.fade(0.15)),
                .backgroundDecode
            ]
        )
        tagsView.arrangedSubviews.forEach { view in
            tagsView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        viewData.types.forEach {
            let tag = PokemonsTypeView()
            tag.nameLabel.adjustsFontSizeToFitWidth = true
            tag.nameLabel.minimumScaleFactor = 0.7
            tag.nameLabel.lineBreakMode = .byTruncatingTail
            tag.setupViewData($0)
            tagsView.addArrangedSubview(tag)
        }
        
        isAccessibilityElement = true
        accessibilityTraits = .staticText
        let tipos = viewData.types.map(\.name).joined(separator: ", ")
        accessibilityLabel = "\(name) número \(viewData.identifier). Tipos : \(tipos)"
    }
}
