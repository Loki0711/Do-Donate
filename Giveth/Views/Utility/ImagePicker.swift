//
//  ImagePicker.swift
//  Giveth
//
//  Created by Jack on 06/07/22.
//
import UIKit
import Photos

public protocol ImagePickerDelegate: class {
    func didSelect(fileName: String, image: UIImage?)
}

open class ImagePicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?

    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?, didSelect name: String) {
        controller.dismiss(animated: true, completion: nil)

        self.delegate?.didSelect(fileName:name, image: image)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil, didSelect: "")
    }

    func generateNameForImage() -> String {
           return "IMG_random_string"
       }

    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var fileName: String?
       /* if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
               let assetResources = PHAssetResource.assetResources(for: asset)
               //print(assetResources.first!.originalFilename)
               fileName = "\(assetResources.first!.originalFilename)"
        }*/
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                fileName = url.lastPathComponent
                //fileType = url.pathExtension
        }
        
        
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil, didSelect: fileName!)
        }
        self.pickerController(picker, didSelect: image, didSelect: fileName!)
    }
}

extension ImagePicker: UINavigationControllerDelegate {

}
