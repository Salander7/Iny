//
//  SavedVC.swift
//  Iny
//
//  Created by Deniz Dilbilir on 19/03/2024.
//

import UIKit

class SavedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Saved"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
    }
    

}
