//
//  BookCollectionViewCell.swift
//  ImageViewToUIWebView
//
//  Created by Kyle Burkholder on 7/8/18.
//  Copyright © 2018 Kyle Burkholder. All rights reserved.
//

import UIKit

protocol BookColletionViewDelegate: AnyObject
{
    func tappedBook(for bookCell: UICollectionViewCell)
}

class BookCollectionViewCell: UICollectionViewCell
{
    
    weak var delegate: BookColletionViewDelegate? = nil
    var image: UIImage? = nil
    {
        didSet
        {
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
        {
        didSet
        {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            imageView.addGestureRecognizer(tapGestureRecognizer)
            imageView.isUserInteractionEnabled = true
        }
    }
    
    @objc func imageTapped()
    {
       print("Image was tapped")
        delegate?.tappedBook(for: self)
    }
}
