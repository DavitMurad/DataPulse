//
//  CatalogueViewModel.swift
//  DataPulse
//
//  Created by Davit Muradyan on 02.06.26.
//

import Foundation
import Combine

class CatalogueViewModel: ObservableObject {
    let manager: HKDataManagerProtocol
    
    init(manager: HKDataManagerProtocol) {
        self.manager = manager
    }
}
