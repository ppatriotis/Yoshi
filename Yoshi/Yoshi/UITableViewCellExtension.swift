//
//  UITableViewCellExtension.swift
//  Yoshi
//
//  Created by Quentin Ribierre on 12/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit

// MARK: - UITableView extension.
extension UITableViewCell {

    /// Setup a long press gesture on the cell to copy the subtitle (detailTextt's text) to the clipboard.
    func setupCopyToClipBoard() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressCopyToClipBoard(_:)))
        addGestureRecognizer(longPressGesture)
    }

    /// Handle long press gesture to copy the cell's subtitle to the clipboard.
    ///
    /// - Parameter sender: Long
    func longPressCopyToClipBoard(_ sender: UIGestureRecognizer) {
        guard sender.state == .began, let subtitle = detailTextLabel?.text else {
            return
        }

        UIPasteboard.general.string = subtitle
        presentToast(message: "\(subtitle) copied! 🎉")
    }
}

extension UIViewController {

    func presentToast(message: String) {
        view.presentToast(message: message)
    }

}

extension UIView {

    func presentToast(message: String) {
        guard let window = window else {
            return
        }

        let toast = UILabel()
        toast.text = message
        toast.textColor = UIColor.white
        toast.backgroundColor = UIColor.clear
        toast.numberOfLines = 0

        let toastBackground = UIView()
        toastBackground.backgroundColor = UIColor.darkGray
        toastBackground.alpha = 0.9
        toastBackground.layer.cornerRadius = 15.0

        let tag = 10293829837420
        window.subviews.forEach { subview in
            if subview.tag == tag {
                subview.removeFromSuperview()
            }
        }
        toastBackground.tag = tag
        window.addSubview(toastBackground)
        window.tag = tag
        window.addSubview(toast)

        if #available(iOS 9.0, *) {
            toast.translatesAutoresizingMaskIntoConstraints = false
            toast.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            toast.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -50).isActive = true
            toast.leftAnchor.constraint(greaterThanOrEqualTo: window.leftAnchor, constant: 35).isActive = true
            toast.rightAnchor.constraint(lessThanOrEqualTo: window.rightAnchor, constant: -35).isActive = true

            toastBackground.translatesAutoresizingMaskIntoConstraints = false
            toastBackground.topAnchor.constraint(equalTo: toast.topAnchor, constant: -5).isActive = true
            toastBackground.leftAnchor.constraint(equalTo: toast.leftAnchor, constant: -20).isActive = true
            toastBackground.rightAnchor.constraint(equalTo: toast.rightAnchor, constant: 20).isActive = true
            toastBackground.bottomAnchor.constraint(equalTo: toast.bottomAnchor, constant: 5).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }

}
