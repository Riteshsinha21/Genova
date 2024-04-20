//
//  UIView.swift
//  Genova
//
//  Created by CTS on 09/04/24.
//

import Foundation
import UIKit

extension UIView {
    func showToast(message: String) {
        let toastLabel = UILabel()
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 12.0)
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        
        let toastWidth: CGFloat = toastLabel.intrinsicContentSize.width + 20
        let toastHeight: CGFloat = 35
        toastLabel.frame = CGRect(x: self.frame.size.width / 2 - toastWidth / 2,
                                  y: self.frame.size.height - toastHeight - 20,
                                  width: toastWidth,
                                  height: toastHeight)
        
        self.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}
