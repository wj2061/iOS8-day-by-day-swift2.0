//
//  PhotoEditingViewController.swift
//  ChromaKeyExtension
//
//  Created by WJ on 15/11/12.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class PhotoEditingViewController: UIViewController, PHContentEditingController {
    let filter = ChromaKeyFilter()
    var glRenderer : GLRenderer!
    var includesChanges = false
    let formatIdentifier = "com.shinobicontrols.chromakey"
    let formatVersion    = "1.0"
    
    
    @IBOutlet weak var thresholdSlider: UISlider!
    
    @IBAction func handleThresholdSliderChanged(sender: UISlider) {
        updateOutputImage()
        includesChanges = true
    }

    var input: PHContentEditingInput?

    override func viewDidLoad() {
        super.viewDidLoad()
        glRenderer = GLRenderer(frame: view.bounds, superView: view)
        view.bringSubviewToFront(thresholdSlider)
    }


    // MARK: - PHContentEditingController

    func canHandleAdjustmentData(adjustmentData: PHAdjustmentData?) -> Bool {
        // Inspect the adjustmentData to determine whether your extension can work with past edits.
        // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
        return adjustmentData?.formatIdentifier == formatIdentifier && adjustmentData?.formatVersion == formatVersion
    }

    func startContentEditingWithInput(contentEditingInput: PHContentEditingInput?, placeholderImage: UIImage) {
        // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
        // If you returned true from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
        // If you returned false, the contentEditingInput has past edits "baked in".
        input = contentEditingInput
        if let image = input?.displaySizeImage{
            filter.inputImage = CIImage(image: image)
        }
        if let adjustmentData = contentEditingInput?.adjustmentData{
            filter.importFilterParameters(adjustmentData.data)
        }
        thresholdSlider.value = filter.threshold
        updateOutputImage()
    }

    func finishContentEditingWithCompletionHandler(completionHandler: ((PHContentEditingOutput!) -> Void)!) {
        // Update UI to reflect that editing has finished and output is being rendered.
        thresholdSlider.enabled = false
        
        // Render and provide output on a background queue.
        dispatch_async(dispatch_get_global_queue(CLong(DISPATCH_QUEUE_PRIORITY_DEFAULT), 0)) {
            // Create editing output from the editing input.
            let output = PHContentEditingOutput(contentEditingInput: self.input!)
            
            // Provide new adjustments and render output to given location.
            let newAdjustmentData = PHAdjustmentData(formatIdentifier: self.formatIdentifier,
                                                        formatVersion: self.formatVersion,
                                                                 data: self.filter.encodeFilterParameters())
            output.adjustmentData = newAdjustmentData
            let fullSizeImage = CIImage(contentsOfURL: self.input!.fullSizeImageURL!)
            UIGraphicsBeginImageContext(fullSizeImage!.extent.size)
            self.filter.inputImage = fullSizeImage
            UIImage(CIImage: self.filter.outputImage!).drawInRect(fullSizeImage!.extent)
            let outputImage = UIGraphicsGetImageFromCurrentImageContext()
            let jpegData = UIImageJPEGRepresentation(outputImage, 1.0)
            UIGraphicsEndImageContext()
            

            jpegData?.writeToURL(output.renderedContentURL, atomically: true)

            completionHandler?(output)
        }
    }

    var shouldShowCancelConfirmation: Bool {
        // Determines whether a confirmation to discard changes should be shown to the user on cancel.
        // (Typically, this should be "true" if there are any unsaved changes.)
        return includesChanges
    }

    func cancelContentEditing() {
        // Clean up temporary files, etc.
        // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
    }
    //MARK: - Utility method
    private func updateOutputImage(){
        filter.threshold = thresholdSlider.value
        if let outputImage = filter.outputImage{
            glRenderer?.renderImage(outputImage)
        }
    }

}
