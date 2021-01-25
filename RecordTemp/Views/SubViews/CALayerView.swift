//
//  CALayerView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/21.
//

import SwiftUI
import Foundation
import AVFoundation

struct CALayerView: UIViewControllerRepresentable {
    var caLayer:CALayer
    var screenWidth: CGFloat
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CALayerView>) -> UIViewController {
        let viewController = UIViewController()

        let aspectRatio = CGSize(width: screenWidth, height: screenWidth)
        
        caLayer.frame = AVMakeRect(aspectRatio: aspectRatio, insideRect: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth))
        
        viewController.view.layer.addSublayer(caLayer)
        //caLayer.frame = viewController.view.layer.frame
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CALayerView>) {
        //caLayer.frame = uiViewController.view.layer.frame
    }
}

