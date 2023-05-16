//
//  DataManager.swift
//  MC2
//
//  Created by Jin on 2023/05/16.
//

import SwiftUI
import CoreData

struct Result: Identifiable {
    var id: String
    var musicTitle: String
    var partIndex: Int
    var imageArr: [UIImage]
}

class DataManager: ObservableObject {
    @Published var finalResults: [FinalResult] = []
    @Published var resultArr: [Result] = []
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    // 데이터 저장
    func saveFinalResult(id: String, musicTitle: String, partIndex: Int, imageArr: [UIImage]) {
        let imageDataArray = imageArr.compactMap { $0.pngData() }
        
        let newFinalResult = FinalResult(context: viewContext)
        newFinalResult.id = id
        newFinalResult.musicTitle = musicTitle
        newFinalResult.partIndex = Int16(partIndex)
        newFinalResult.imageArr = imageDataArray
        
        do {
            try viewContext.save()
            fetchFinalResults()
        } catch {
            // 저장 중 에러 처리
        }
    }
    
    // 데이터 불러오기
    func fetchFinalResults() {
        DispatchQueue.main.async {
            self.finalResults = []
        }
        
        let fetchRequest: NSFetchRequest<FinalResult> = FinalResult.fetchRequest()
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            
            finalResults = results
            
            for result in results {
                self.tranceResult(result: result)
            }
            
        } catch {
            // 불러오기 중 에러 처리
        }
    }
    
    func tranceResult(result: FinalResult) {
        DispatchQueue.main.async {
            self.resultArr = []
        }
        
        let id: String = result.id ?? ""
        let musicTitle: String = result.musicTitle ?? ""
        let partIndex: Int = Int(result.partIndex)
        let imageDataArr: [Data] = result.imageArr ?? []
        var imageArr: [UIImage] = []
        
        for image in imageDataArr {
            imageArr.append(UIImage(data: image) ?? UIImage())
        }
        
        let result = Result(id: id, musicTitle: musicTitle, partIndex: partIndex, imageArr: imageArr)
        
        DispatchQueue.main.async {
            self.resultArr.append(result)
        }
    }
}
