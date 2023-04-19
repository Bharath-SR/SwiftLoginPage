import Foundation
import UIKit
//import FirebaseDatabase
import Firebase

class AddNotes : UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
  
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func addPost(_ sender: Any) {
        
        let title = titleTextField.text
        let description = descriptionTextField.text
        let newDocument = db.collection("NotesApp").document()
        newDocument.setData(["Title" : title , "Description" : description  ,"id":newDocument.documentID])
        
        //Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
        
        
       
    }
    
}
