//
//  CustomButton.swift
//  COVID19 MUST
//
//  Created by Taha on 5/4/20.
//  Copyright © 2020 AITC. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            setUpView()
        }
    }
        
    @IBInspectable var cornerRadiusValue: CGFloat = 10.0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }

    func setUpView() {
        
        // cornerRadius
        self.layer.cornerRadius = cornerRadiusValue

        // borderWidth
        self.layer.borderWidth = borderWidth
        
        // borderColor
        self.layer.borderColor = borderColor?.cgColor
        
        self.clipsToBounds = true
    }

}
