//
//  CustomView.swift
//  MyWeather
//
//  Created by mac on 10/4/21.
//

import UIKit

@IBDesignable
class CustomView: UIView {

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
    
    @IBInspectable var borderColor: UIColor? {
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
