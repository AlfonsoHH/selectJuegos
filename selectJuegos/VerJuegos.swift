import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    

    @IBOutlet weak var tableView: UITableView!
    //variables
    var juegos: NSArray = NSArray()
    var juego : Juego = Juego()
    let titulo = "Juegos"
    var Sections_Arr=[Data]()
    var row=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()        
    }
    
    func itemsDownloaded(items: NSArray) {
        juegos = items
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fila = tableView.dequeueReusableCell(withIdentifier: "fila", for: indexPath)
        let juegoActual: Juego = juegos[indexPath.row] as! Juego
        fila.textLabel!.text = juegoActual.JuegoMesa
        fila.detailTextLabel!.text = juegoActual.Autor
        return fila
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titulo
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        self.row = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swipeLeft" {
            if let variableEnviada = segue.destination as? ViewController2 {
                variableEnviada.juego = self.juegos[row] as! Juego
            }
        }
    }
}

