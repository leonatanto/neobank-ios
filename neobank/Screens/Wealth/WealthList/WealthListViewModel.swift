//
//  WealthListViewModel.swift
//  neobank
//
//  Created by Leon Natanto on 18/07/24.
//

import Foundation

class WealthListViewModel {
    var wealthData: WealthRepository.WealthData?
    var filteredData: [WealthRepository.ProductGroup] = []
    
    func fetchData(completion: @escaping (Result<Void, Error>) -> Void) {
        let wealthRepository = WealthRepository()
        
        wealthRepository.fetchData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let wealthData):
                self.wealthData = wealthData
                self.filteredData = wealthData.data
                completion(.success(()))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterData(for index: Int) {
        guard let wealthData = wealthData else { return }
        if index < wealthData.data.count {
            filteredData = [wealthData.data[index]]
        } else {
            filteredData = []
        }
    }
    
    func getProductName(_ name: String) -> String {
        let lowercasedName = name.lowercased()
        switch lowercasedName {
        case "flexible":
            return "Fleksibel"
        case "fixed income":
            return "Bunga tetap"
        default:
            return name
        }
    }
}
