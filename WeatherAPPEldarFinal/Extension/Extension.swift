//
//  Extension.swift
//  WeatherAPPEldarFinal
//
//  Created by Eldar Gaiypov on 27/5/23.
//
//
//import Foundation
//import UIKit
//
//extension NSObject {
//    func flexibleHeight(to: CGFloat) -> CGFloat {
//        return UIScreen.main.bounds.height * to / 926
//    }
//    func flexibleWidth(to: CGFloat) -> CGFloat {
//        return UIScreen.main.bounds.width * to / 428
//    }
//}
//
//extension UILabel {
//    func createCategoryLabel(text: String) -> UILabel{
//        let label = UILabel()
//        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//        label.font = UIFont(name: "Montserrat-Bold", size: 14)
//        label.textAlignment = .center
//        label.text = text
//        return label
//    }
//    func createIndexLabel(text: String) -> UILabel{
//        let label = UILabel()
//        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//        label.font = UIFont(name: "Montserrat-Regular", size: 20)
//        label.textAlignment = .center
//        label.text = text
//        return label
//    }
//}
//
//extension UIView {
//    func gradient(view: UIView) {
//        let gradientLayer = CAGradientLayer()
//        let topColor = UIColor(red: 49/255, green: 163/255, blue: 197/255, alpha: 1)
//        let bottomColor = UIColor(red: 0/255, green: 36/255, blue: 47/255, alpha: 1)
//        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
//        gradientLayer.locations = [0, 1]
//        view.layer.addSublayer(gradientLayer)
//        gradientLayer.frame = view.bounds
//    }
//}
//
//class CustomTextField: UITextField {
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        super.textRect(forBounds: bounds.insetBy(dx: 16, dy: 0))
//    }
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        super.editingRect(forBounds: bounds.insetBy(dx: 16, dy: 0))
//    }
//}
