//
//  ScannerView.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/13.
//

import Foundation
import SwiftUI
import Vision
import VisionKit

struct ScannerView: UIViewControllerRepresentable {
    private let completionHandler: ([String]?) -> Void
    
    init(completion: @escaping ([String]?) -> Void){
        self.completionHandler = completion
    }
    
    typealias UIVIewControllerType = VNDocumentCameraViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerView>) -> VNDocumentCameraViewController {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = context.coordinator
        return documentCameraViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<ScannerView>) {
        
    }
    
    func makeCoordinator() -> DocumentCameraCoordinator {
        return DocumentCameraCoordinator(completion: completionHandler)
    }
    
    class DocumentCameraCoordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([String]?) -> Void
        
        init(completion: @escaping ([String]?) -> Void) {
            self.completionHandler = completion
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            print("Document camera view controller did finish with", scan)
            let recognizer = TextRecognizer(cameraScan: scan)
            recognizer.recognizeText(withCompletionHandler: completionHandler)
            
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera view controller did finish with error", error)
            completionHandler(nil)
        }
    }
}
