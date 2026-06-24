//
//  UIElements.swift
//  Programatic UI
//
//  Created by Prem Kumar Gundu on 6/4/26.
//
import UIKit

struct UIElements{
    
//    static var nextButton: UIButton = {
//        let button = UIButton()
//        //button.setTitle("Next Button", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    static func button(_ title: String, titleColor: UIColor = .black, backgroundColor: UIColor = .white, action: Selector? = nil) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.configuration = .plain()
        button.backgroundColor = backgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        if let action{
            button.addTarget(self, action: action, for: .touchUpInside)
        }
        
        return button
    }
    
    static func imageView(profileImage: String = "", tintColor: UIColor = .black) -> UIImageView{
        let imageView = UIImageView()
        imageView.image = profileImage != "" ? UIImage(named: profileImage) : UIImage(systemName: "person.circle.fill")
        imageView.tintColor = tintColor
        //imageView.backgroundColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func label(text: String,textColor: UIColor = .black, fontSize: CGFloat = 16, fontWeight: UIFont.Weight = .regular) -> UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        return label
    }
    
       
    
}

