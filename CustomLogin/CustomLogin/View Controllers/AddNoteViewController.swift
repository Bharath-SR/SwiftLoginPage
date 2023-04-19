import UIKit
import Firebase

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addNotes: UIButton!
    var db = Firestore.firestore()
    var notes = [NoteModel] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = .white
        fetchNotes()
    }

    func fetchNotes() {
        db.collection("NotesApp").addSnapshotListener { querySnapshot, error in
            if let error = error{
                print("Error : \(error)")
            } else {
            var notes = [NoteModel]()
            guard let snapshot = querySnapshot else {
                return
                }
            for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
                let data = document.data()
                var id = data["id"] as! String
                var description = data["Description"] as! String
                var title = data["Title"] as! String
                let note =  NoteModel(id: id, description: description, title: title)
                notes.append(note)
            }
                self.notes = notes
                self.tableView.reloadData()
            }
        }
        
    }
    // delete  a document
    @IBAction func deleteButtonTapped(_ sender: Any) {

        db.collection("NotesApp").document("SmRmGV3duUvSI2fGY9LQ").delete(){ err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        self.tableView.reloadData()
    }
    
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("inside numberofRowsInSection  \(notes.count)")
        return notes.count
        }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "PostCell")
            let note = notes[indexPath.row]
            cell!.textLabel?.text = note.title
            return cell!
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let editVC = storyboard?.instantiateViewController(withIdentifier: "EditViewController" ) as! EditViewController
        editVC.note = note
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @IBAction func addNotes(_ sender: UIButton) {
        print("click add notes")
//        SecondViewController
        let addNote = storyboard?.instantiateViewController(withIdentifier: "EditViewController" ) as! EditViewController
        navigationController?.pushViewController(addNote, animated: true)
    }
    

}
