//
//  AppIBDesignableUI.swift
//  ChanceUpon
//
//  Created by Dharmani Apps mini on 11/20/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

private var kAssociationKeyMaxLength: Int = 0



@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    

    
 
    
    
}
extension UITextField{
    @IBInspectable var maxLength: Int {
                get {
                    if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                        return length
                    } else {
                        return Int.max
                    }
                }
                set {
                    objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
                    self.addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
                }
            }

    //The method is used to cancel the check when use Chinese Pinyin input method.
            //Becuase the alphabet also appears in the textfield when inputting, we should cancel the check.
            func isInputMethod() -> Bool {
                if let positionRange = self.markedTextRange {
                    if let _ = self.position(from: positionRange.start, offset: 0) {
                        return true
                    }
                }
                return false
            }


    @objc func checkMaxLength(textField: UITextField) {

                guard !self.isInputMethod(), let prospectiveText = self.text,
                    prospectiveText.count > maxLength
                    else {
                        return
                }

                let selection = selectedTextRange
                let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
                text = prospectiveText.substring(to: maxCharIndex)
                selectedTextRange = selection
            }
    
   
}

class PaddingTextField: UITextField {

@IBInspectable var paddingLeft: CGFloat = 0
@IBInspectable var paddingRight: CGFloat = 0

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y,
                      width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height);
}

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return textRect(forBounds: bounds)
}}



extension UINavigationController {
    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
@IBDesignable class InsetLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    var insets: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        }
        set {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjSize = super.sizeThatFits(size)
        adjSize.width += leftInset + rightInset
        adjSize.height += topInset + bottomInset
        
        return adjSize
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += leftInset + rightInset
        contentSize.height += topInset + bottomInset
        
        return contentSize
    }
}
extension UIImageView {
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
@IBDesignable extension UIImageView {

    @IBInspectable var masksToBounds: Bool {
        set {
            layer.masksToBounds = newValue
        }
        get {
            return layer.masksToBounds
        }
    }

    @IBInspectable  var borderWidthImg: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadiusImg: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColorImg: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


