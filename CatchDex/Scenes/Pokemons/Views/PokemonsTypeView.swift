//
//  PokemonsTypeView.swift
//  CatchDex
//
//  Created by Fernanda Perovano on 25/09/25.
//

import UIKit

final class PokemonsTypeView: UIView {
    
    // MARK: - View Components
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let imageTypeView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Private Properties
    
    private var items: [PokemonsScene.ViewData] = []
    
    // MARK: - Intalization
    
    override init(
        frame: CGRect = .zero
    ) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubViews()
        constrainSubViews()
        layer.cornerRadius = 8
        backgroundColor = .white
    }
    
    private func addSubViews() {
        addSubview(imageTypeView)
        addSubview(nameLabel)
    }
    
    private func constrainSubViews() {
        constrainImageTypeView()
        constrainNameLabel()
    }
    
    // MARK: - Constrain setup
    
    private func constrainImageTypeView() {
        imageTypeView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            topConstant: 6,
            leadingConstant: 12,
            bottomConstant: 6,
            widthConstant: 24,
            heightConstant: 24
        )
    }
    
    private func constrainNameLabel() {
        nameLabel.anchor(
            leading: imageTypeView.trailingAnchor,
            trailing: trailingAnchor,
            leadingConstant: 6,
            trailingConstant: 12
        )
        nameLabel.anchorCenterYToSuperview()
    }
    
    // MARK: - Public Methods
    
    func setupViewData(_ viewData: PokemonsScene.ViewDataType) {
        backgroundColor = viewData.backgroundColor
        nameLabel.text = viewData.name
        imageTypeView.image = viewData.image
        
        isAccessibilityElement = true
        accessibilityLabel = "Tipo \(viewData.name)"
        accessibilityTraits = .staticText
    }
}

