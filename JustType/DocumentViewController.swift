//
//  DocumentViewController.swift
//  JustType
//
//  Created by Prudhvi Gadiraju on 5/25/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var document: Document?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleShare))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDocumentViewController))
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                self.title = self.document?.fileURL.deletingPathExtension().lastPathComponent
                self.textView.text = self.document?.text
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @objc func dismissDocumentViewController() {
        document?.text = textView.text
        document?.updateChangeCount(.done)
        
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
    @objc func handleShare(sender: UIBarButtonItem) {
        guard let url = document?.fileURL else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = sender
        present(activityViewController, animated: true, completion: nil)
    }
}
