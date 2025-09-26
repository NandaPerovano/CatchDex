//
//  PokemonsView.swift
//  CatchDex
//
//  Created by Fernanda Perovano on 25/09/25.
//

import UIKit
import Lottie


protocol PokemonsViewProtocol {
    func setupViewState(_ viewState: PokemonsScene.ViewState)
    func setFooterLoading(_ isLoading: Bool)
}

final class PokemonsView: UIView, PokemonsViewProtocol {
    
    // MARK: - Callbacks
    
    private let onSelectItem: (PokemonsScene.ViewData) -> Void
    var onLoadMore: (() -> Void)?
    
    // MARK: - View Components
    
    private let animationView: LottieAnimationView = {
        let view = LottieAnimationView(name: "PokeballLoading", bundle: .main)
        view.contentMode = .scaleAspectFill
        view.loopMode = .loop
        view.animationSpeed = 1
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = true
        return tableView
    }()
    
    private let footerSpinner : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        return view
    }()
    
    // MARK: - Data
    
    private var items: [PokemonsScene.ViewData] = []
    
    // MARK: - Intalization
    
    init(
        onSelectItem: @escaping (PokemonsScene.ViewData) -> Void,
        frame: CGRect = .zero
    ) {
        self.onSelectItem = onSelectItem
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(tableView)
        addSubview(animationView)
        
        tableView.fillSuperview()
        animationView.anchorCenterSuperview()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(PokemonItemViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        backgroundColor = .white
    }
    
    // MARK: - PokemonsViewProtocol
    
    func setupViewState(_ viewState: PokemonsScene.ViewState){
        switch viewState {
        case .loading:
            animationView.isHidden = false
            animationView.play()
            tableView.isHidden = true
            setFooterLoading(false)
        case .error:
            animationView.isHidden = true
            tableView.isHidden = true
            setFooterLoading(false)
        case .success(let array):
            animationView.isHidden = true
            tableView.isHidden = false
            items = array
            tableView.reloadData()
            setFooterLoading(false)
        }
    }

    func  setFooterLoading(_ isLoading: Bool) {
        if isLoading {
            footerSpinner.startAnimating()
            footerSpinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 56)
            tableView.tableFooterView = footerSpinner
        } else {
            footerSpinner.stopAnimating()
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
}

// MARK: - Table View's Methods

extension PokemonsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PokemonItemViewCell = tableView.dequeueCell(PokemonItemViewCell.self, for: indexPath)
        cell.setupViewData(items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        onSelectItem(items[indexPath.row])
    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !items.isEmpty else { return }
        if indexPath.row == items.count - 1 {
            onLoadMore?()
        }
    }
}
