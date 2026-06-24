//
//  ConstraintsHelper.swift
//  Programatic UI
//
//  Created by Prem Kumar Gundu on 6/8/26.
//
import UIKit

func pinAllCorners(child: UIView, parent: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0 ){
    NSLayoutConstraint.activate([
        child.topAnchor.constraint(equalTo: parent.topAnchor, constant: top),
        child.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: bottom),
        child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant : leading),
        child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: trailing)
    ])
}

func pinLeftRightCorners(child: UIView, parent: UIView, leading: CGFloat = 0, trailing: CGFloat = 0){
    NSLayoutConstraint.activate([
        child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant : leading),
        child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: trailing)
    ])
}

func pinLeadingCorner(child: UIView, parent: UIView, leading: CGFloat = 0){
    NSLayoutConstraint.activate([
        child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant : leading),
    ])
}

func pinTrailingCorner(child: UIView, parent: UIView, trailing: CGFloat = 0){
    NSLayoutConstraint.activate([
        child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: trailing)
    ])
}

func pinTopCorner(child: UIView, parent: UIView, top: CGFloat = 0){
    NSLayoutConstraint.activate([
        child.topAnchor.constraint(equalTo: parent.topAnchor, constant: top),
    ])
}

func pinTopToBottomCorner(child: UIView, parent: UIView, top: CGFloat = 0){
    NSLayoutConstraint.activate([
        child.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: top),
    ])
}

func pinBottomCorner(child: UIView, parent: UIView, bottom: CGFloat = 0){
    NSLayoutConstraint.activate([
        child.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: bottom),
    ])
}

func setWidthHeightConstraints(element: UIView, width: CGFloat = 0, height: CGFloat = 0){
    if width > 0{
        NSLayoutConstraint.activate([
            element.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    if height > 0{
        NSLayoutConstraint.activate([
            element.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
}

func centerX(child: UIView, parent: UIView){
    NSLayoutConstraint.activate([
        child.centerXAnchor.constraint(equalTo: parent.centerXAnchor)
    ])
}

func centerY(child: UIView, parent: UIView){
    NSLayoutConstraint.activate([
        child.centerYAnchor.constraint(equalTo: parent.centerYAnchor)
    ])
}
