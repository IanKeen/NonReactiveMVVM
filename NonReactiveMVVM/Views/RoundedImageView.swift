//
//  RoundedImageView.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 23/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    @IBInspectable var borderColor: UIColor = .darkGray {
        didSet { self.setNeedsLayout(); self.layoutIfNeeded() }
    }
    @IBInspectable var borderWidth: CGFloat = 0.5 {
        didSet { self.setNeedsLayout(); self.layoutIfNeeded() }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.midX
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
    }
}
