//
//  MovieDetailsController.swift
//  Movie Suggestion App (UIKit)
//
//  Created by Prem Kumar Gundu on 6/24/26.
//

import UIKit

class MovieDetailsController: UIViewController{
    
    let genreLabel = UIElements.label(text: "genre", textColor: .white, fontSize: 15, fontWeight: .bold)
    let titleLabel = UIElements.label(text: "Title", textColor: .white, fontSize: 25, fontWeight: .bold)
    let ratingLabel = UIElements.label(text: "5.0", textColor: .red, fontSize: 18, fontWeight: .semibold)
    let overviewLabel = UIElements.label(text: "Overview", textColor: .systemGray, fontSize: 20, fontWeight: .bold)
    let detailsLabel = UIElements.label(text: "Details", textColor: .systemGray, fontSize: 20, fontWeight: .bold)
    let descriptionLabel = UIElements.label(text: "Description",textColor: .white, fontSize: 15, fontWeight: .semibold)
    let popularityLabel = UIElements.label(text: "Popularity:",textColor: .systemGray, fontSize: 15, fontWeight: .semibold)
    let releaseDateLabel = UIElements.label(text: "2021",textColor: .brown, fontSize: 18, fontWeight: .semibold)
    let languageLabel = UIElements.label(text: "Language:",textColor: .systemGray, fontSize: 15, fontWeight: .semibold)
    let adultLabel = UIElements.label(text: "Adult Content:",textColor: .systemGray, fontSize: 15, fontWeight: .semibold)
    let votesLabel = UIElements.label(text: "Votes:",textColor: .systemGray, fontSize: 15, fontWeight: .semibold)
    let englishTitleLabel = UIElements.label(text: "English Title:",textColor: .systemGray, fontSize: 15, fontWeight: .semibold)
    let englishTitleValue = UIElements.label(text: "Value ",textColor: .white, fontSize: 18, fontWeight: .semibold)
    let languageValue = UIElements.label(text: "Value ",textColor: .white, fontSize: 18, fontWeight: .semibold)
    let popularityValue = UIElements.label(text: "Value ",textColor: .white, fontSize: 18, fontWeight: .semibold)
    let votesValue = UIElements.label(text: "Value ",textColor: .white, fontSize: 18, fontWeight: .semibold)
    let adultValue = UIElements.label(text: "Value ",textColor: .white, fontSize: 18, fontWeight: .semibold)
    //var bannerColor: UIColor = .systemGray
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bannerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let genreView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rowStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 15
        return view
    }()
    
    let englishTitleStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 5
        return view
    }()
    
    let languageStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 5
        return view
    }()
    
    let adultStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 5
        return view
    }()
    
    let popularityStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 5
        return view
    }()
    
    let votesStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 5
        return view
    }()
    
    let detailsStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 5
        return view
    }()
    
    let starIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  UIImage(systemName: "star.fill")
        imageView.tintColor = .systemOrange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        //imageView.image =  UIImage(systemName: "star.fill")
        //imageView.tintColor = .systemOrange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //loadData()
        setUpUI()
    }
}

extension MovieDetailsController{
    func setUpUI(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bannerView)
        contentView.addSubview(genreView)
        genreView.addSubview(genreLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rowStack)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(detailsStack)
        
        rowStack.addArrangedSubview(starIcon)
        rowStack.addArrangedSubview(ratingLabel)
        rowStack.addArrangedSubview(releaseDateLabel)
        
        englishTitleStack.addArrangedSubview(englishTitleLabel)
        englishTitleStack.addArrangedSubview(englishTitleValue)
        
        languageStack.addArrangedSubview(languageLabel)
        languageStack.addArrangedSubview(languageValue)
        
        adultStack.addArrangedSubview(adultLabel)
        adultStack.addArrangedSubview(adultValue)
        
        popularityStack.addArrangedSubview(popularityLabel)
        popularityStack.addArrangedSubview(popularityValue)
        
        votesStack.addArrangedSubview(votesLabel)
        votesStack.addArrangedSubview(votesValue)
        
        detailsStack.addArrangedSubview(englishTitleStack)
        detailsStack.addArrangedSubview(languageStack)
        detailsStack.addArrangedSubview(adultStack)
        detailsStack.addArrangedSubview(popularityStack)
        detailsStack.addArrangedSubview(votesStack)
        
        genreView.backgroundColor = .red
        genreView.layer.cornerRadius = 10
        genreView.clipsToBounds = true
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .justified
        
        //bannerView.backgroundColor = bannerColor
        bannerView.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)

        ])
        
        pinAllCorners(child: contentView , parent: scrollView)
        
        
        pinLeftRightCorners(child: bannerView, parent: contentView)
        pinTopCorner(child: bannerView, parent: contentView)
        setWidthHeightConstraints(element: bannerView, height: 220)
        pinAllCorners(child: backgroundImage , parent: bannerView)
        
        pinLeadingCorner(child: genreView, parent: bannerView, leading: 12)
        pinBottomCorner(child: genreView, parent: bannerView, bottom: -12)
        
        pinAllCorners(child: genreLabel, parent: genreView, top: 4, bottom: -4, leading: 10, trailing: -10)
        
        pinLeftRightCorners(child: titleLabel, parent: contentView, leading: 16, trailing: -16)
        pinTopToBottomCorner(child: titleLabel, parent: bannerView, top: 16)
        
        pinTopToBottomCorner(child: rowStack, parent: titleLabel, top: 8)
        pinLeadingCorner(child: rowStack, parent: contentView, leading: 16)
        
        pinTopToBottomCorner(child: overviewLabel, parent: rowStack, top: 20)
        pinLeadingCorner(child: overviewLabel, parent: contentView, leading: 16)
        
        pinTopToBottomCorner(child: descriptionLabel, parent: overviewLabel, top: 8)
        pinLeftRightCorners(child: descriptionLabel, parent: contentView, leading: 16, trailing: -16)
        
        pinTopToBottomCorner(child: detailsLabel, parent: descriptionLabel, top: 24)
        pinLeadingCorner(child: detailsLabel, parent: contentView, leading: 16)
        
        pinTopToBottomCorner(child: detailsStack, parent: detailsLabel, top: 10)
        //pinLeftRightCorners(child: detailsStack, parent: contentView, leading: 16, trailing: -16)
        pinLeadingCorner(child: detailsStack, parent: contentView, leading: 16)
        pinBottomCorner(child: detailsStack, parent: contentView, bottom: -30)
        
    }
        
}

extension MovieDetailsController{
    func loadData(movie: Movie?){
        
        guard let movie else {return}
        
//        let movie = Movie(
//            title: "Inception",
//            genre: ["Sci-Fi"].prefix(2).joined(separator: " • "),
//            rating: 8.8,
//            year: 2010,
//            overview: "A skilled thief is offered a chance to have his criminal record erased if he can successfully perform inception — planting an idea into someone's subconscious. A skilled thief is offered a chance to have his criminal record erased if he can successfully perform inception — planting an idea into someone's subconscious. A skilled thief is offered a chance to have his criminal record erased if he can successfully perform inception — planting an idea into someone's subconscious. A skilled thief is offered a chance to have his criminal record erased if he can successfully perform inception — planting an idea into someone's subconscious.",
//            director: "Christopher Nolan",
//            duration: "2h 28min",
//            //bannerColor: .systemBlue
//        )

        genreLabel.text = movie.genreIds.map{ String($0) }.joined(separator: " • ")
        titleLabel.text = movie.originalTitle
        ratingLabel.text = String(movie.voteAverage)
        descriptionLabel.text = movie.overview
        popularityValue.text = "\(movie.popularity)"
        releaseDateLabel.text = movie.releaseDate
        languageValue.text = "\(movie.originalLanguage.uppercased())"
        englishTitleValue.text = movie.title
        votesValue.text = String(movie.voteCount)
        adultValue.text = movie.adult ? "Yes" : "No"
        //bannerColor =  .blue
        UIImage().downloadImage(for: movie.backdropPath){
            result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async{
                    [weak self] in
                    self?.backgroundImage.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
