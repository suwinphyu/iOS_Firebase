//
//  AddItemViewController.swift
//  firebase_restaurant_assignment
//
//  Created by Su Win Phyu on 10/24/19.
//  Copyright © 2019 swp. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseFirestore

class AddItemViewController: UIViewController {
    
    static let identifier = "AddItemViewController"
    static var dataPath : String = ""
    var imageReference : StorageReference!
    var imageUrl : String = ""
    
    @IBOutlet weak var imgViewUploadImage: UIImageView!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtFoodName: UITextField!
    @IBOutlet weak var txtWaitingTime: UITextField!
    @IBOutlet weak var txtRating: UITextField!
    @IBOutlet weak var lblFoodItemName: UILabel!
    
    var data : String! {
        didSet{
            if let data = data {
                switch data {
                case "entress":
                    AddItemViewController.dataPath = Sharedconstants.DB_COLLECTION_PATH_ENTREES
                    break
                case "drinks":
                    AddItemViewController.dataPath = Sharedconstants.DB_COLLECTION_PATH_DRINKS
                    break
                case "mains":
                    AddItemViewController.dataPath = Sharedconstants.DB_COLLECTION_PATH_MAINS
                       break
                case "desserts":
                    AddItemViewController.dataPath = Sharedconstants.DB_COLLECTION_PATH_DESSERTS
                    break
                default:
                    AddItemViewController.dataPath = Sharedconstants.DB_COLLECTION_PATH_ENTREES
                    break
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnUploadImage(_ sender: Any) {
        // to define unique image name
        let imageName = UUID().uuidString
        
        //to build folder and image reference
        imageReference = Storage.storage().reference().child("images").child(imageName)
        
        
        ImagePickerManager().pickImage(self){(image) in
            self.imgViewUploadImage.image = image
            
            // compress quaity=  0.0 to 1.0
            guard let image = self.imgViewUploadImage.image , let data = image.jpegData(compressionQuality: 0.8) else {
                return
            }
            
            //to upload image to cloud
            self.imageReference.putData(data, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
            }
            
            Dialog.showAlert(viewController: self, title: "Success", message: "Image is uploaded successfully")
            
            
        }
        
    }
    func getImageUrl(){
        imageReference.downloadURL { (url, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.imageUrl = url?.path ?? ""
          //  print(self.imageUrl)
            
        }
    }
    
    @IBAction  func btnCreate(_ sender: Any) {
        getImageUrl()
        let db = Firestore.firestore()
        db.collection(AddItemViewController.dataPath).addDocument(data: [
            "amount" :txtAmount.text ?? ""  ,
            "food_name" : txtFoodName.text ?? "",
            "imageUrl" : imageUrl ,
            "rating" : txtRating.text ?? "" ,
            "waiting_time ": txtWaitingTime.text ?? ""
            ])
        Dialog.showAlert(viewController: self, title: "Success", message: "Your item is added successfully.")
    }
    
    
}
