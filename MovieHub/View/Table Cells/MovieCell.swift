//
//  MovieCell.swift
//  Movie Suggestion App (UIKit)
//
//  Created by Prem Kumar Gundu on 6/24/26.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //var onError: ((String) -> Void)?
    // MARK: - UI Elements
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        //image.image = UIImage(systemName: "film") // movie icon
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 3
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .red
        label.textAlignment = .right
        return label
    }()
    
    let starIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  UIImage(systemName: "star.fill")
        imageView.tintColor = .systemOrange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let ratingStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 5
        return view
    }()
    
    private let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Stack Views
    
    private let cellStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movieInfoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .equalSpacing
        view.spacing = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let disClosureIndicator: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadCellUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

extension MovieTableViewCell {
    
    func configure(with viewModel: MovieDetailsViewModel) {
        
        movieTitle.text = viewModel.title
        genreLabel.text = viewModel.genre
        ratingLabel.text = viewModel.rating
        releaseYearLabel.text = viewModel.releaseYear
        overviewLabel.text = viewModel.overview
        //movieImage.image = UIImage(systemName: "film")
        movieImage.downloadImage(for: viewModel.posterPath, defaultImage: "film")
    }
}


// MARK: - UI Setup

extension MovieTableViewCell {
    
    private func loadCellUI() {
        
        contentView.backgroundColor = .black
        
        contentView.addSubview(cellStackView)
        
        cellStackView.addArrangedSubview(movieImage)
        cellStackView.addArrangedSubview(movieInfoStackView)
        cellStackView.addArrangedSubview(releaseYearLabel)
        cellStackView.addArrangedSubview(disClosureIndicator)
        
        cellStackView.layer.cornerRadius = 20
        cellStackView.clipsToBounds = true
        
        containerView.addSubview(genreLabel)
        
        ratingStack.addArrangedSubview(starIcon)
        ratingStack.addArrangedSubview(ratingLabel)
        
        movieInfoStackView.addArrangedSubview(movieTitle)
        movieInfoStackView.addArrangedSubview(containerView)
        movieInfoStackView.addArrangedSubview(overviewLabel)
        movieInfoStackView.addArrangedSubview(ratingStack)
    }
    
    private func setUpConstraints() {
        
        pinAllCorners(child: cellStackView, parent: contentView, top: 20, leading: 20, trailing: -20)
        setWidthHeightConstraints(element: movieImage, width: 125, height: 125)
        setWidthHeightConstraints(element: releaseYearLabel, width: 50)
        setWidthHeightConstraints(element: disClosureIndicator, width: 25, height: 25)
        pinAllCorners(child: genreLabel, parent: containerView, leading: 5, trailing: -5)
    }
}
