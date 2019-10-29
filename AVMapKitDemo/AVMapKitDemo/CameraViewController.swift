//
//  CameraViewController.swift
//  AVMapKitDemo
//
//  Created by Arman Vaziri on 10/28/19.
//  Copyright © 2019 ArmanVaziri. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate  {
    
    var takenPhoto: UIImage!
    let captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice!
    var previewLayer: CALayer!
    var takePhoto: Bool = false
    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCamera()
        cameraButton.layer.cornerRadius = cameraButton.frame.height /  2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func prepareCamera() {
        
        // Check camera authorization here
        // ----------
        // ^^^^^^^^^^
        
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        if let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices as [AVCaptureDevice]? {
            self.captureDevice = availableDevices.first
            beginSession()
        }
    }
    
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch  {
            print(error.localizedDescription)
        }
        
        if let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) as AVCaptureVideoPreviewLayer? {
            self.previewLayer = previewLayer
            self.view.layer.addSublayer(self.previewLayer)
            self.previewLayer.frame = self.view.layer.frame
            captureSession.startRunning()
            
            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): NSNumber(value:kCVPixelFormatType_32BGRA)]
            dataOutput.alwaysDiscardsLateVideoFrames = true
            
            if captureSession.canAddOutput(dataOutput) {
                captureSession.addOutput(dataOutput)
            }
            
            captureSession.commitConfiguration()
            
            let queue = DispatchQueue(label: "Swaaag")
            dataOutput.setSampleBufferDelegate(self, queue: queue)
        }
        
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        takePhoto = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if takePhoto {
            takePhoto = false
            if let image = self.getImageFromSampleBuffer(buffer: sampleBuffer) {
                takenPhoto = image
                DispatchQueue.main.async {
                    let vc = ViewController()
                    vc.imageToPin = image
                    
                    // Create Image pin here, hasn't been implemented correctly
//                    let annotation = MKPointAnnotation()
//                    
//                    annotation.title = "Image"
//                    annotation.subtitle = "Here is the image you took here"
//                    annotation.coordinate = vc.locationManager.location!.coordinate
//                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func getImageFromSampleBuffer(buffer: CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
                
            }
        }
        return nil
    }
    

     
    

}
