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
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 3
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .orange
        label.textAlignment = .right
        return label
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
        
        viewModel.fetchPosterImage(completion: { [weak self] result in
            DispatchQueue.main.async{
                switch result{
                case .success(let image):
                    self?.movieImage.image = image
                case .failure:
                    self?.movieImage.image = UIImage(systemName: "film")
                }
            }
        })
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
        
        movieInfoStackView.addArrangedSubview(movieTitle)
        movieInfoStackView.addArrangedSubview(genreLabel)
        movieInfoStackView.addArrangedSubview(overviewLabel)
        movieInfoStackView.addArrangedSubview(ratingLabel)
    }
    
    private func setUpConstraints() {
        
        pinAllCorners(child: cellStackView, parent: contentView, top: 20, leading: 20, trailing: -20)
        setWidthHeightConstraints(element: movieImage, width: 125, height: 125)
        setWidthHeightConstraints(element: releaseYearLabel, width: 50)
        setWidthHeightConstraints(element: disClosureIndicator, width: 25, height: 25)
    }
}
