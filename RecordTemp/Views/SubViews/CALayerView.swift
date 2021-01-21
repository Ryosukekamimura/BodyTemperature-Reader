//
//  CALayerView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/21.
//

import SwiftUI
import Foundation

struct CALayerView: UIViewControllerRepresentable {
    var caLayer:CALayer
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CALayerView>) -> UIViewController {
        let viewController = UIViewController()
        
        caLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width*4/3)
        
        viewController.view.layer.addSublayer(caLayer)
        //caLayer.frame = viewController.view.layer.frame
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CALayerView>) {
        //caLayer.frame = uiViewController.view.layer.frame
    }
}

