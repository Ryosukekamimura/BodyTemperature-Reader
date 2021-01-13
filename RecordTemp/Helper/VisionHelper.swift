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
    private let recognitionLevel: VNRequestTextRecognitionLevel = .accurate
    // the maximum number of candidates to return. This can't exceed 10
    private let maximumCandidates = 1

    func performVisionRecognition(uiImage: UIImage?, handler: @escaping(_ recognizedStrings: [String]) -> ()) {
        performRecognition(uiImage: uiImage)
    }

    //MARK: PRIVATE FUNCTIONS
    func performRecognition(uiImage: UIImage?){
        guard let imageSelected = uiImage else { return }
        
        // Get the CGImage on which to perform request.
        guard let cgImage = imageSelected.cgImage else { return }
        
        // Create a new image-request handler
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        // Create a new request to recognized text
        let request = VNRecognizeTextRequest(completionHandler: recognizedTextHandler)
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
    
    private func recognizedTextHandler(request: VNRequest, error: Error?){
        
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        
        let recognizedStrings = observations.compactMap{ observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(maximumCandidates).first?.string
        }
        
        // Process the recognized strings.
        print(recognizedStrings)
        VisionFormatter.instance.removeCharactersFromStrings(recognized: recognizedStrings)
    }
}


class TextRecognizer {
    let cameraScan: VNDocumentCameraScan
     
    init(cameraScan: VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
     
    private let queue = DispatchQueue(label: "com.augmentedcode.scan", qos: .default, attributes: [], autoreleaseFrequency: .workItem)
     
    func recognizeText(withCompletionHandler completionHandler: @escaping ([String]) -> Void) {
        queue.async {
            let images = (0..<self.cameraScan.pageCount).compactMap({ self.cameraScan.imageOfPage(at: $0).cgImage })
            let imagesAndRequests = images.map({ (image: $0, request: VNRecognizeTextRequest()) })
            let textPerPage = imagesAndRequests.map { image, request -> String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do {
                    try handler.perform([request])
                    guard let observations = request.results as? [VNRecognizedTextObservation] else { return "" }
                    return observations.compactMap({ $0.topCandidates(1).first?.string }).joined()
                }
                catch {
                    print(error)
                    return ""
                }
            }
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}
