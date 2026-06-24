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
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .orange
        label.textAlignment = .right
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Stack Views
    
    private let cellStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 15
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
    
    func configure(with movie: Movie) {
        movieTitle.text = movie.originalTitle
        genreLabel.text = movie.genreIds .map { String($0) }.joined(separator: " • ")
        ratingLabel.text = "⭐ \(movie.voteAverage)"
        releaseDateLabel.text = movie.releaseDate
        
        UIImage().downloadImage(for: movie.posterPath, completion: {
            [weak self] result in
            switch result{
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.movieImage.image = UIImage(data: imageData)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.movieImage.image = UIImage(systemName: "film")
                }
                //self?.onError?(error.rawValue)
                print(error)
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
        cellStackView.addArrangedSubview(releaseDateLabel)
        
        movieInfoStackView.addArrangedSubview(movieTitle)
        movieInfoStackView.addArrangedSubview(genreLabel)
        movieInfoStackView.addArrangedSubview(ratingLabel)
    }
    
    private func setUpConstraints() {
        
        pinAllCorners(child: cellStackView, parent: contentView, top: 20, leading: 20, trailing: -20)
        setWidthHeightConstraints(element: movieImage, width: 75, height: 75)
        setWidthHeightConstraints(element: releaseDateLabel, width: 100)
    }
}
