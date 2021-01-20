//
//  VisionHelper.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/07.
//

import Foundation
import SwiftUI
import Vision
import VisionKit

struct VisionHelper{
    
    static var instance = VisionHelper()
    
    //MARK: PROPERTIES
    var uiImage: UIImage?
    
    //MARK: CONSTANT
    //
    private let recognitionLevel: VNRequestTextRecognitionLevel = .accurate
    
    // the maximum number of candidates to return. This can't exceed 10
    private let maximumCandidates = 1

    func performVisionRecognition(uiImage: UIImage?, handler: @escaping(_ recognizedStrings: [String]) -> ()) {
        performRecognition(uiImage: uiImage) { (recognizedTextStrings) in
            handler(recognizedTextStrings)
        }
    }
    
    

    //MARK: PRIVATE FUNCTIONS
    private func performRecognition(uiImage: UIImage?, handler: @escaping (_ recognizedTextStrings: [String]) -> Void){
        guard let imageSelected = uiImage else { return }
        
        // Get the CGImage on which to perform request.
        guard let cgImage = imageSelected.cgImage else { return }
        
        // Create a new image-request handler
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        // Create a new request to recognized text
        let request = VNRecognizeTextRequest { (request, error) in
            recognizedTextHandler(request: request, error: error) { (recognizedTextStrings) in
                handler(recognizedTextStrings)
            }
        }
        
        request.recognitionLevel = recognitionLevel
        request.usesLanguageCorrection = true
        
        
        // Send the requests to the request handler.
        DispatchQueue.global(qos: .userInitiated).async {
            do{
                // Perform the text-recognition request
                try imageRequestHandler.perform([request])
            }catch {
                print("Unable to perform the requests: \(error)")
            }
        }
    }
    
    private func recognizedTextHandler(request: VNRequest, error: Error?, handler: @escaping (_ recognizedTextStrings: [String]) -> Void){
        
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        
        let recognizedStrings = observations.compactMap{ observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(maximumCandidates).first?.string
        }
        
        // Process the recognized strings.
        print(recognizedStrings)
        
        handler(recognizedStrings)
        
    }
}
