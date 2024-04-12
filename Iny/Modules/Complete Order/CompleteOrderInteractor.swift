//
//  CompleteOrderInteractor.swift
//  Iny
//
//  Created by Deniz Dilbilir on 23/04/2024.
//

import Foundation

protocol OrderInteractorDelegate: AnyObject {
    func orderProcessedSuccessfully()
    func orderProcessingFailed(withError error: Error)
}

protocol CompleteOrderInteractorOutputs: AnyObject {
   
    func alert(title: String, message: String)
    func orderSuccess()
}

class OrderInteractor {
    weak var delegate: OrderInteractorDelegate?
    weak var presenter: CompleteOrderInteractorOutputs?
    
  
}


