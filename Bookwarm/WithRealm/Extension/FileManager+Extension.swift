//
//  FileManager+Extension.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/06.
//

import UIKit

extension UIViewController {
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        guard let data = image.jpegData(compressionQuality: 1.0) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard
            let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                             in: .userDomainMask)
                .first else {
            return UIImage(systemName: "star")
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)

        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star")
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        
        guard
            let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                             in: .userDomainMask)
                .first else {
            return
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
}
