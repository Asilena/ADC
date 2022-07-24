//
//  UserModel.swift
//  ADC_test
//
//  Created by Elisa Berkane on 23/07/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserModel: ObservableObject {
    
    @Published var fabricList = [Fabric]()
    @Published var userName = ""
    var userDataListener: ListenerRegistration?
    var fabricDataListener: ListenerRegistration?
    
    
    func getUserData() {
        
        // Check that there's a logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        // Get the meta data for that user
        let db = Firestore.firestore()
        let ref = db.collection("users").document(Auth.auth().currentUser!.uid)
        userDataListener = ref.addSnapshotListener { snapshot, error in
            
            // Check there's no errors
            guard error == nil, snapshot != nil else {
                return
            }
            
            // Parse the data out and set the user meta data
            let data = snapshot!.data()
            DispatchQueue.main.async {
                self.userName = data?["name"] as? String ?? ""
            }
            
            
        }
    }
    
    func getFabricData() {
        
        // Check that there's a logged in user
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        // Get the meta data for that user
        let db = Firestore.firestore()
        print("User ID")
        print(Auth.auth().currentUser!.uid)
        let ref = db.collection("users").document(Auth.auth().currentUser!.uid).collection("Fabrics")
        fabricDataListener = ref.addSnapshotListener { snapshot, error in
            
            // Check there's no errors
            guard error == nil, snapshot != nil else {
                return
            }
            
            snapshot?.documentChanges.forEach {diff in
                
                if diff.type == .added {
                    
                    // Create a new Fabric instance
                    var f = Fabric()
                    
                    // Parse data
                    f.id = diff.document.documentID as? String ?? UUID().uuidString
                    f.name = diff.document["name"] as? String ?? ""
                    f.type = diff.document["type"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self.fabricList.append(f)
                    }
                }
                if diff.type == .modified {
                    print("Document modified")
                    let docId = diff.document.documentID
                    let docIndex = self.fabricList.firstIndex(where: {$0.id == docId})
                    DispatchQueue.main.async {
                        self.fabricList[docIndex!].id = diff.document.documentID as? String ?? UUID().uuidString
                        self.fabricList[docIndex!].name = diff.document["name"] as? String ?? ""
                        self.fabricList[docIndex!].type = diff.document["type"] as? String ?? ""
                        print(self.fabricList[docIndex!].type)
                    }
                }
                if diff.type == .removed {
                    let docId = diff.document.documentID
                    let docIndex = self.fabricList.firstIndex(where: {$0.id == docId})
                    self.fabricList.remove(at: docIndex!)
                }
            }
            
        }
        
    }
    
    func deleteFabric(at offsets: IndexSet) {
        let db = Firestore.firestore()
        
        // Specify document to delete
        for i in offsets {
            db.collection("users").document(Auth.auth().currentUser!.uid).collection("Fabrics").document(self.fabricList[i].id).delete { error in
                //Check if successful
                if error == nil{
                    // No errors
                    
                    
                }
            }
        }
        
    }
}




