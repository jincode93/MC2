//
//  DanceStore.swift
//  MC2
//
//  Created by Jin on 2023/05/07.
//

import Foundation
import Firebase
import FirebaseFirestore

class DanceStore: ObservableObject {
    @Published var music: [Music] = []
    @Published var danceParts: [DancePart] = []
    @Published var selectedMusic: Music?
    @Published var selectedDancePart: DancePart?
    @Published var tabIndex: Int = 0
    @Published var splitIndex: Int = 0
    
    let database = Firestore.firestore()

    // MARK: - Music 목록 받아오는 메서드
    func musicWillFetchDB() async {
        do {
            let documents = try await database.collection("Music").getDocuments()
            
            for document in documents.documents {
                let docData = document.data()
                
                let id: String = docData["id"] as? String ?? ""
                let danceLevel: String = docData["danceLevel"] as? String ?? ""
                let musicTitle: String = docData["musicTitle"] as? String ?? ""
                let singer: String = docData["singer"] as? String ?? ""
                let albumArt: UIImage = UIImage(named: "\(musicTitle)") ?? UIImage()
                
                var danceParts: [DancePart] = []
                
                let danceDocuments = try await database.collection("Music").document(id)
                    .collection("DancePart").order(by: "partIndex").getDocuments()
                
                for danceDocument in danceDocuments.documents {
                    let danceDocData = danceDocument.data()
                    
                    let danceId: String = danceDocData["id"] as? String ?? ""
                    let partIndex: Int = danceDocData["partIndex"] as? Int ?? 0
                    let partMusic: String = danceDocData["partMusic"] as? String ?? ""
                    
                    var danceFrameImage: [UIImage] = []
                    for i in 1...8 {
                        if let image = UIImage(named: "\(musicTitle).part\(partIndex).\(i)") {
                            danceFrameImage.append(image)
                        } else {
                            print("danceFrameImage append fail")
                        }
                    }
                    
                    var dancePauseImage: [UIImage] = []
                    for i in 1...8 {
                        if let image = UIImage(named: "\(musicTitle)Part\(partIndex).\(i)") {
                            dancePauseImage.append(image)
                        } else {
                            print("dancePauseImage append fail")
                        }
                    }
                    
                    let danceVideo: String = danceDocData["danceVideo"] as? String ?? ""
                    
                    let dancePart = DancePart(id: danceId, partIndex: partIndex, partMusic: partMusic, dancePauseImage: dancePauseImage, danceFrameImage: danceFrameImage, danceVideo: danceVideo)
                    
                    danceParts.append(dancePart)
                }
                
                let music = Music(id: id, danceLevel: danceLevel, musicTitle: musicTitle, singer: singer, albumArt: albumArt, dancePartArr: danceParts)
                
                DispatchQueue.main.async {
                    self.music.append(music)
                    print("@Log Music append finish")
                }
            }
        } catch {
            print("musicWillFetchDB Function Error: \(error)")
        }
    }
}
