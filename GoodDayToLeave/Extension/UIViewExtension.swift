//
//  UIViewExtension.swift
//  mPI
//
//  Created by Macintosh on 6/7/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import UIKit

extension UIView {

    private static let kRotationAnimationKey = "rotationanimationkey"
    
    class func nibDefault() -> UINib {
        let nibName = String(describing: self)
        let nib = UINib.init(nibName: nibName, bundle: nil)
        return nib
    }
    
    @objc func startRotating(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            rotationAnimation.isCumulative = true
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    @objc func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
    
    class func initWithDefaultNib() -> Self {
        return initWithNibTemplate()
    }
    
    private class func initWithNibTemplate<T>() -> T {
        let nibName = String(describing: self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first
        return view as! T
    }
    
    class func nib() -> UINib {
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: nil)
    }

    var originalFrame: CGRect {
        let currentTransform = transform
        transform = .identity
        let originalFrame = frame
        transform = currentTransform
        return originalFrame
    }

    /// Helper to get point offset from center
    func centerOffset(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x - center.x, y: point.y - center.y)
    }

    /// Helper to get point back relative to center
    func pointRelativeToCenter(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x + center.x, y: point.y + center.y)
    }

    /// Helper to get point relative to transformed coords
    func newPointInView(_ point: CGPoint) -> CGPoint {
        // get offset from center
        let offset = centerOffset(point)
        // get transformed point
        let transformedPoint = offset.applying(transform)
        // make relative to center
        return pointRelativeToCenter(transformedPoint)
    }

    var newTopLeft: CGPoint {
        return newPointInView(originalFrame.origin)
    }

    var newTopRight: CGPoint {
        var point = originalFrame.origin
        point.x += originalFrame.width
        return newPointInView(point)
    }

    var newBottomLeft: CGPoint {
        var point = originalFrame.origin
        point.y += originalFrame.height
        return newPointInView(point)
    }

    var newBottomRight: CGPoint {
        var point = originalFrame.origin
        point.x += originalFrame.width
        point.y += originalFrame.height
        return newPointInView(point)
    }

    func setAnchorPoint(anchorPoint: CGPoint) {
        var newPoint = CGPoint(x: self.bounds.size.width * anchorPoint.x, y: self.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: self.bounds.size.width * self.layer.anchorPoint.x, y: self.bounds.size.height * self.layer.anchorPoint.y)

        newPoint = newPoint.applying(self.transform)
        oldPoint = oldPoint.applying(self.transform)

        var position : CGPoint = self.layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x;

        position.y -= oldPoint.y;
        position.y += newPoint.y;

        self.layer.position = position;
        self.layer.anchorPoint = anchorPoint;
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 1
        
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func borderView() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.groupTableViewBackground.cgColor
    }
    
    func cornerRadiusView() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func addDragging() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedAction(_ :)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func draggedAction(_ pan: UIPanGestureRecognizer) {
        
    }
    
    //MARK: hide Keyboard click view
    func removeEnditing() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(removeAction(_ :)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func removeAction(_ pan: UIPanGestureRecognizer) {
        self.endEditing(true)
    }
}

extension UIVisualEffectView {
    //MARK: hide Keyboard click view
    func onActionClickvisual() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(removekeyboardAction(_ :)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func removekeyboardAction(_ pan: UIPanGestureRecognizer) {
        self.endEditing(true)
    }
}
