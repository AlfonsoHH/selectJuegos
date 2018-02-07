import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol, HomeModel2Protocol, HomeModel3Protocol {
    

    @IBOutlet weak var tableView: UITableView!
    //variables
    var juegos: NSArray = NSArray()
    var juegos2: NSArray = NSArray()
    var juegos3: NSArray = NSArray()
    var juegoTest: NSArray = NSArray()
    
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
        
        let homeModel2 = HomeModel2()
        homeModel2.delegate = self
        homeModel2.downloadItems()
        
        let homeModel3 = HomeModel3()
        homeModel3.delegate = self
        homeModel3.downloadItems()
        
        juegoTest = [
            juegos,
            juegos2,
            juegos3
        ]
        
        //var array = juegoTest[0] as! NSArray
        //print (juegos.count)
    }
    
    //llama a la funcion para descargar los objetos
    func itemsDownloaded(items: NSArray) {
        juegos = items
        self.tableView.reloadData()
    }
    
    func itemsDownloaded2(items: NSArray) {
        juegos2 = items
        self.tableView.reloadData()
    }
    
    func itemsDownloaded3(items: NSArray) {
        juegos3 = items
        self.tableView.reloadData()
    }
    
    //funcion que dice el numero de filas segun el tamaño del array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    //función que dice el numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return juegoTest.count
    }
    /*
    //funcion que introduce los datos en cada fila
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fila = tableView.dequeueReusableCell(withIdentifier: "fila", for: indexPath)
        let juegoActual: Juego = juegos[indexPath.row] as! Juego
        fila.textLabel!.text = juegoActual.JuegoMesa
        fila.detailTextLabel!.text = juegoActual.Autor
        return fila
    }
     let fila = tableView.dequeueReusableCell(withIdentifier: "fila", for: indexPath) as! filacustomizadaTableViewCell
     fila.textLabel?.text = data[indexPath.section][indexPath.row]
    */
    
    //funcion que introduce los datos en cada fila
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fila = tableView.dequeueReusableCell(withIdentifier: "fila", for: indexPath)
        
        /*juegoTest = [
            juegos,
            juegos2,
            juegos3
        ]*/
        print(juegos3.count)
        //var array = juegoTest[indexPath.section] as! NSArray
        //var juegoActual: Juego = array[indexPath.row] as! Juego
        //print (juegoActual.JuegoMesa)
        //fila.textLabel!.text = juegoActual.JuegoMesa!
        //fila.detailTextLabel!.text = juegoActual.Autor
        return fila
    }
    
    //titulo para cada seccion
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titulo
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        self.row = indexPath.row
    }
    
    //Función para controlar el gesture del swipe
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swipeLeft" {
            if let variableEnviada = segue.destination as? ViewController2 {
                variableEnviada.juego = self.juegos[row] as! Juego
            }
        }
    }
}

