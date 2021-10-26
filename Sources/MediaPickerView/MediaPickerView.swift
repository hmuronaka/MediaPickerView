//
//  MediaPickerView.swift
//
//  Created by Hiroaki Muronaka on 2021/10/26

import SwiftUI
import MediaPlayer

/// MPMediaPickerControllerをSwiftUIで使えるようにしただけのWrapper View
///
public struct MediaPickerView: UIViewControllerRepresentable {

    public struct Configuration {
        public let prompt: String?
        public let allowsPickingMultipleItems: Bool
        public let showsCloudItems: Bool
        public let showsItemsWithProtectedAssets: Bool
        
        public init(prompt: String? = nil, allowsPickingMultipleItems: Bool = false, showsCloudItems: Bool = true, showsItemsWithProtectedAssets: Bool = false) {
            self.prompt = prompt
            self.allowsPickingMultipleItems = allowsPickingMultipleItems
            self.showsCloudItems = showsCloudItems
            self.showsItemsWithProtectedAssets = showsItemsWithProtectedAssets
        }
    }
    
    public class Coordinator: NSObject, MPMediaPickerControllerDelegate {
        var parent: MediaPickerView
        
        init(_ parent: MediaPickerView) {
            self.parent = parent
        }
        
        public func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
            parent.onSelect?(mediaItemCollection)
            mediaPicker.dismiss(animated: true, completion: nil)
        }
        
        public func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
            parent.onCancel?()
            mediaPicker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    private let mediaTypes: MPMediaType
    private let config: Configuration?
    private let onSelect: ( (_:MPMediaItemCollection) -> ())?
    private let onCancel: ( () -> ())?
    
    public init(mediaTypes: MPMediaType,
                config: Configuration? = nil,
                onSelect: ( (_:MPMediaItemCollection) -> ())? = nil,
                onCancel: ( () -> ())? = nil
    ) {
        self.mediaTypes = mediaTypes
        self.config = config
        self.onSelect = onSelect
        self.onCancel = onCancel
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MPMediaPickerController(mediaTypes: self.mediaTypes)
        vc.delegate = context.coordinator
        if let config = config {
            vc.prompt = config.prompt
            vc.allowsPickingMultipleItems = config.allowsPickingMultipleItems
            vc.showsCloudItems = config.showsCloudItems
            vc.showsItemsWithProtectedAssets = config.showsItemsWithProtectedAssets
        }
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

