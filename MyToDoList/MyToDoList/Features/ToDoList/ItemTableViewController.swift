
import UIKit


class ItemTableViewController: UITableViewController {
    
    let viewmodel = ItemTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewmodel.fetchData()
    }
    
    func configure() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(1).cgColor, UIColor.systemPink.withAlphaComponent(0.5).cgColor]
        gradientLayer.frame = self.tableView.bounds
        let backgroundView = UIView(frame: self.tableView.bounds)
        backgroundView.layer.addSublayer(gradientLayer)
        tableView.backgroundView = backgroundView
    }
    
    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: { _ in
            if let title = alert.textFields![0].text {
                guard !title.isEmpty else {return}
                let index = self.viewmodel.todolist.count
                self.viewmodel.addItem(title)
                self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .top)
                self.viewmodel.saveData()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewmodel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        
        if indexPath.row < viewmodel.todolist.count {
            let item = viewmodel.returnToDoRow(indexPath.row)
            cell.textLabel?.text = item.title
            
            let accessory: UITableViewCell.AccessoryType = item.done ? .checkmark : .none
            cell.accessoryType = accessory
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < viewmodel.todolist.count {
            viewmodel.toggleDone(indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            viewmodel.saveData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.row < viewmodel.todolist.count {
            viewmodel.deleteRow(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
            viewmodel.saveData()
        }
    }
}
