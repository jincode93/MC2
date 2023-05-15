//
//  SigninSignupStore.swift
//  MC2
//
//  Created by Jin on 2023/05/07.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class UserStore: ObservableObject {
    // 로그인
    @Published var email: String = ""
    @Published var pw: String = ""
    @Published var singInCheck: Bool = false
    @Published var currentUserUid: String = ""
    
    // 로그인 상태 확인
    @Published var currentUser: Firebase.User?
    
    // 회원가입
    @Published var nickName: String = ""
    @Published var signUpEmail: String = ""
    @Published var signUpPW: String = ""
    @Published var signUpPWCheck: String = ""
    @Published var signCheck: Bool = false
    
    // firebase 데이터 불러오기
    @Published var user: User?
    @Published var userMusics: [UserMusic] = []
    @Published var userDanceParts: [UserDancePart] = []
    
    @Published var photoURLs: [String] = []
    
    let database = Firestore.firestore()
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    // MARK: - 로그인 메서드
    func signInUser() async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: pw)
            DispatchQueue.main.async {
                self.currentUser = result.user
                self.currentUserUid = result.user.uid
                self.singInCheck = true
            }
        } catch {
            print("Failed to login user:", error)
        }
    }
    
    // MARK: - 로그아웃 메서드
    func logout() {
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
    
    // MARK: - 회원가입 메서드
    func createNewAccount() {
        Auth.auth().createUser(withEmail: signUpEmail, password: signUpPW) { result, error in
            if let error = error {
                print("Failed to create user:", error)
                return
            }
            self.userInfoToDatabase()
            self.signCheck = true
        }
    }
    
    // MARK: - user 정보 database에 저장
    func userInfoToDatabase() {
        guard let currentUser = Auth.auth().currentUser else { return print("return no current user")}
        let progressMusicArray: [String] = []
        
        database.collection("Users").document(currentUser.uid)
            .setData([
                "id": currentUser.uid,
                "email": signUpEmail,
                "nickName": nickName,
                "progressMusicArray": progressMusicArray,
                "recentMusic": "",
                "recentPart": 0
            ]) { err in
                if let err {
                    print("userInfoToDatabase error occured: \(err.localizedDescription)")
                }
            }
        
        let userMusicId: String = UUID().uuidString
        
        database.collection("Users").document(currentUserUid).collection("UserMusic").document(userMusicId)
            .setData([
                "id": userMusicId
            ])
        
        let userDancePartId: String = UUID().uuidString
        
        database.collection("Users").document(currentUserUid).collection("UserMusic").document(userMusicId)
            .collection("UserDancePart").document(userDancePartId)
            .setData([
                "id": userDancePartId
            ])
    }
    
    // MARK: - UserMusic안에 들어갈 UserDancePart를 database에서 불러오는 메서드
    func userDancePartWillFetchDB(userId: String, musicId: String) async {
        do {
            DispatchQueue.main.async {
                self.userDanceParts = []
            }
            
            let documents = try await database.collection("Users").document(userId).collection("UserMusic").document(musicId).collection("UserDancePart").getDocuments()
            
            for document in documents.documents {
                let docData = document.data()
                
                let id: String = docData["id"] as? String ?? ""
                let partIndex: Int = docData["partIndex"] as? Int ?? 0
                let userDanceImages: [UIImage] = docData["userDanceImages"] as? [UIImage] ?? []
                let danceDate: Date = docData["danceDate"] as? Date ?? Date.now
                
                if !userDanceImages.isEmpty {
                    let userDancePart = UserDancePart(id: id, partIndex: partIndex, userDanceImages: userDanceImages, danceDate: danceDate)
                    
                    DispatchQueue.main.async {
                        self.userDanceParts.append(userDancePart)
                    }
                }
            }
        } catch {
            print("userDancePartWillFetchDB Function Error: \(error)")
        }
    }
    
    // MARK: - User에 들어갈 UserMusic을 database에서 불러오는 메서드
    func userMusicWillFetchDB(userId: String) async {
        do {
            DispatchQueue.main.async {
                self.userMusics = []
            }
            
            let documents = try await database.collection("Users").document(userId).collection("UserMusic").getDocuments()
            
            for document in documents.documents {
                let docData = document.data()
                
                let id: String = docData["id"] as? String ?? ""
                let musicTitle: String = docData["musicTitle"] as? String ?? ""
                let singer: String = docData["singer"] as? String ?? ""
                let danceLevel: String = docData["danceLevel"] as? String ?? ""
                
                await userDancePartWillFetchDB(userId: currentUserUid, musicId: docData["id"] as? String ?? "")
                
                if musicTitle != "" {
                    let userMusic = UserMusic(id: id, musicTitle: musicTitle, singer: singer, danceLevel: danceLevel, userDanceParts: self.userDanceParts)
                    
                    DispatchQueue.main.async {
                        self.userMusics.append(userMusic)
                    }
                }
            }
        } catch {
            print("userMusicWillFetchDB Function Error: \(error)")
        }
    }
    
    // MARK: - User 정보를 database에서 불러오는 메서드
    func userWillFetchDB() async {
        do {
            let document = try await database.collection("Users").document(currentUserUid).getDocument()
            let docData = document.data()
            let id: String = docData?["id"] as? String ?? ""
            let email: String = docData?["email"] as? String ?? ""
            let nickName: String = docData?["nickName"] as? String ?? ""
            let recentMusic: String = docData?["recentMusic"] as? String ?? ""
            let recentPart: Int = docData?["recentPart"] as? Int ?? 0

            await userMusicWillFetchDB(userId: currentUserUid)
            
            let user = User(id: id, email: email, nickName: nickName, recentMusic: recentMusic, recentPart: recentPart, userMusics: self.userMusics)
            
            DispatchQueue.main.async {
                self.user = user
            }
        } catch {
            print("userWillFetchDB Function Error: \(error)")
        }
    }
    
    // MARK: - User 정보를 database로 보내는 메서드
    func userSendToDB(selectedMusic: Music, selectedDancePart: DancePart, userDanceImages: [UIImage]) async {
            database.collection("Users").document(currentUserUid)
                .updateData([
                    "recentMusic": selectedMusic.musicTitle,
                    "recentPart": selectedDancePart.partIndex
                ]) { err in
                    if let err {
                        print("userSendToDB Function Error: \(err.localizedDescription)")
                    }
                }
        
        await self.userMusicSendToDB(selectedMusic: selectedMusic, selectedDancePart: selectedDancePart, userDanceImages: userDanceImages)
    }
    
    // MARK: - UserMusic 정보를 database로 보내는 메서드
    func userMusicSendToDB(selectedMusic: Music, selectedDancePart: DancePart, userDanceImages: [UIImage]) async {
        
        let musicId: String = UUID().uuidString
        
        database.collection("Users").document(currentUserUid).collection("UserMusic").document(musicId)
            .setData([
                "id": musicId,
                "musicTitle": selectedMusic.musicTitle,
                "singer": selectedMusic.singer,
                "danceLevel": selectedMusic.danceLevel
            ]) { err in
                if let err {
                    print("userMusicSendToDB Function Error: \(err.localizedDescription)")
                }
            }
        
        await self.userDancePartSendToDB(selectedMusic: selectedMusic, selectedDancePart: selectedDancePart, userDanceImages: userDanceImages, musicId: musicId)
    }
    
    func userDancePartSendToDB(selectedMusic: Music, selectedDancePart: DancePart, userDanceImages: [UIImage], musicId: String) async {
        
        self.danceImageToStorage(dancePhotos: userDanceImages) { [weak self] photoURLs in
            guard let self = self else { return }
            
            let id: String = UUID().uuidString
            
            print("StartDancPart Send To DB")
            database.collection("Users").document(currentUserUid).collection("UserMusic").document(musicId).collection("UserDancePart").document(id)
                .setData([
                    "id": id,
                    "partIndex": selectedDancePart.partIndex,
                    "userDanceImages": self.photoURLs,
                    "danceDate": Date.now
                ]) { err in
                    if let err {
                        print("userDancePartSendToDB Function Error: \(err.localizedDescription)")
                    }
                }
            
            print("DancePart Send To DB Success")
        }
    }
    
    // MARK: - 사진찍은 이미지들을 storage로 보내고 URL 주소를 받아오는 메서드
    func danceImageToStorage(dancePhotos: [UIImage], completion: @escaping ([String]) -> Void) {
        let uid = UUID().uuidString
        let ref = Storage.storage().reference(withPath: uid)
        
        DispatchQueue.main.async {
            self.photoURLs = []
        }
        
        let dispatchGroup = DispatchGroup()
        
        for photo in dancePhotos {
            dispatchGroup.enter()
            
            guard let photoData = photo.jpegData(compressionQuality: 0) else {
                dispatchGroup.leave()
                continue
            }
            
            ref.putData(photoData) { metadata, error in
                if let error = error {
                    print("Photo put data error: \(error)")
                    dispatchGroup.leave()
                    return
                }
                
                ref.downloadURL() { url, error in
                    if let error = error {
                        print("Photo URL download error: \(error)")
                        dispatchGroup.leave()
                        return
                    }
                    guard let url = url else {
                        dispatchGroup.leave()
                        return
                    }
                    DispatchQueue.main.async {
                        self.photoURLs.append(url.absoluteString)
                    }
                    print("imageUrl send to DB success: \(url.absoluteString)")
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(self.photoURLs)
        }
    }
}
