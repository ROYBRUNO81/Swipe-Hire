//
//  ImagePicker.swift
//  SwipeHire
//
//  Created by Bruno Ndiba Mbwaye Roy on 4/26/25.
//


import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    let sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate   = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_: UIImagePickerController, context _: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let ui = info[.originalImage] as? UIImage {
                parent.selectedImage = ui
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
