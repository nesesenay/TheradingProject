import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    let urlStrings = ["https://wallpaperaccess.com/full/3417770.jpg", "https://wallpaperaccess.com/full/648057.jpg"]
    var data = Data()
    var tracker = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.global().async {
            self.data = try!  Data(contentsOf: URL(string: self.urlStrings[self.tracker])!) // background thread
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data) // main thread
            }
            
        }
        
        
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeImage))
        
    }
    
    @objc func changeImage() {
        
        if tracker == 0 {
            tracker += 1
        } else {
            tracker -= 1
        }
        
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!) // background thread
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data) // main thread
            }
            
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Therading Test"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
}

