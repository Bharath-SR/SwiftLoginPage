import UIKit
import FirebaseAuth
class MainViewController: UIViewController {

    @IBOutlet weak var signUpBUtton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
          automaticLogin()
      }
    
    func automaticLogin() {
        if Auth.auth().currentUser != nil {
            guard let notesViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.notesViewController) as? ViewController
            else { return }
            

        }
    }
    
    
    func setUpElements(){
        Utilities.styleFilledButton(signUpBUtton)
        Utilities.styleHollowButton(loginButton)
    }


}


