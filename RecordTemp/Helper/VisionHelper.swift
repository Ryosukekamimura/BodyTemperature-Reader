//
//  VisionHelper.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import Foundation
import SwiftUI
import Vision

struct VisionHelper{
    
    static let instance = VisionHelper()
    
    var uiImage: UIImage?
    private let recognitionLevel: VNRequestTextRecognitionLevel = .accurate

    func prepareRequest(uiImage: UIImage?){
        guard let uiImage = uiImage else { return }
        // Create a new request to recognize text
        let request = VNRecognizeTextRequest { (request, error) in
            guard let results = request.results as? [VNRecognizedTextObservation] else{ return }
            for textObservation in results{
                let candidates = textObservation.topCandidates(1)
                // output result
                for recognizedText in candidates{
                    print(candidates)
                    let confidence = recognizedText.confidence*100
                    print("温度\(recognizedText.string), 信頼性\(confidence)")
                }
            }
        }
        request.recognitionLevel = recognitionLevel
        request.usesLanguageCorrection = true
        
        // perform recognition
        performRecognition(uiImage: uiImage, request: request)
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func performRecognition(uiImage: UIImage?, request: VNRecognizeTextRequest){
        guard let imageSelected = uiImage else { return }
        
        // Get the CGImage on which to perform request.
        guard let cgImage = imageSelected.cgImage else { return }
        
        // Create a new image-request handler
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        do{
            // Perform the text-recognition request
            try requestHandler.perform([request])
        }catch {
            print("Unable to perform the requests: \(error)")
        }
    }
    
    
}


