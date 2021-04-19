//
//  CustomTextField.swift
//  Messages
//
//  Created by Cleber Reis on 31/03/21.
//

import UIKit

class CustomTextField: UITextField {
    init(placeholder: String, isSecure: Bool) {
        super.init(frame: .zero)
        
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        tintColor = .white
        keyboardAppearance = .default
        keyboardType = .default
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [.foregroundColor: UIColor.white])
        
        if isSecure {
            isSecureTextEntry = true
        } else {
            isSecureTextEntry = false
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
