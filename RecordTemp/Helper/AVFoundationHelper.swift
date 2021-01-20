//
//  AVFoundationHelper.swift
//  RecordTemp
//
//  Created by 神村亮佑 on 2021/01/19.
//

import Foundation
import UIKit
import Combine
import AVFoundation
import SwiftUI

class AVFoundationVM: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, ObservableObject, AVCapturePhotoCaptureDelegate {
    ///撮影した画像
    @Published var image: UIImage?
    ///プレビュー用レイヤー
    var previewLayer:CALayer!

    ///撮影開始フラグ
    
//    private var isTakePhoto:Bool = false
    
    // caputure Session
    private let captureSession = AVCaptureSession()
    
    // capture photo output
    private let capturePhotoOutput = AVCapturePhotoOutput()


    override init() {
        super.init()

        prepareCamera()
        setUpCaptureSession()
    }
    
    
    //MARK: PRIVATE FUNCTIONS
    private func prepareCamera() {

        
//        captureSession.sessionPreset = .photo
//
//        if let availableDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices.first {
//            capturepDevice = availableDevice
//        }
    }

    private func setUpCaptureSession() {
        
        // setting up camera ...
        
        do {
            // Setting configs ...
            captureSession.beginConfiguration()
            
            let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice!)
            
            captureSession.sessionPreset = .photo
            
            // check and Adding to Session for input....
            if self.captureSession.canAddInput(captureDeviceInput){
                self.captureSession.addInput(captureDeviceInput)
            }
            // check and Addoing to Session for output ...
            if self.captureSession.canAddOutput(self.capturePhotoOutput){
                self.captureSession.addOutput(capturePhotoOutput)
            }
            
            self.captureSession.commitConfiguration()
            
        } catch {
            print("ERROR \(error.localizedDescription)")
        }

        // Setting Preview Layer
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = previewLayer

        
    }

    func startSession() {
        if captureSession.isRunning { return }
        captureSession.startRunning()
    }

    func endSession() {
        if !captureSession.isRunning { return }
        captureSession.stopRunning()
    }
    
    func takePicture(){
        self.capturePhotoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)

    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if error != nil{
            return
        }
        print("take pictures...")
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        let uiImage = UIImage(data: imageData)!
        // resized
        self.image = uiImage.resized(toWidth: uiImage.size.width/4)!
        
        
        
    }
    
    

    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        if _takePhoto {
//            _takePhoto = false
//            if let image = getImageFromSampleBuffer(buffer: sampleBuffer) {
//                DispatchQueue.main.async {
//                    self.image = image
//                }
//            }
//        }
//    }
//
//    private func getImageFromSampleBuffer (buffer: CMSampleBuffer) -> UIImage? {
//
//        VisionHelper.instance.performVisionRecognition(cmSampleBuffer: buffer) { (returnedStrings) in
//            print("CMSampleBuffer")
//            print(returnedStrings)
//        }
//
//
//        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
//            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
//            let context = CIContext()
//
//            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
//
//            if let image = context.createCGImage(ciImage, from: imageRect) {
//                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
//            }
//        }
//
//        return nil
//    }
}
