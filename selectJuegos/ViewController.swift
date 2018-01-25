import UIKit

class ViewController: UIViewController, UITableViewDataSource{
    

    @IBOutlet weak var tableView: UITableView!
    @IBAction func bt_recargar(_ sender: UIButton) {
        self.tableView.reloadData()
        
    }
    
    var juegos = NSMutableArray()
    
    let titulo = "Juegos"
    
    var Sections_Arr=[Data]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getFromJSON()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let fila = tableView.dequeueReusableCell(withIdentifier: "fila", for: indexPath)
        let juegoActual: Juego = juegos[indexPath.row] as! Juego
        fila.textLabel!.text = juegoActual.JuegoMesa
        print(juegoActual.JuegoMesa)
        fila.detailTextLabel!.text = juegoActual.Autor
        return fila
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titulo
    }

    func getFromJSON() {
        //To connect to the URL
        let URL = NSURL(string: "http://iesayala.ddns.net/mls/SelectJuegosMesa.php")
        let request = NSMutableURLRequest(url: URL! as URL)
        

        request.httpMethod = "POST"
        let postString = ""
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            //si no hay errores se llama al interpretador del JSON
            print("1")
            self.parseJSON(data!)
        }
        task.resume()
        
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            print("2")
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let juego = Juego()
            
            //the following insures none of the JsonElement values are nil through optional binding
            let JuegoMesa = jsonElement["JuegoMesa"] as? String
            let Autor = jsonElement["Autor"] as? String
            let TiempoMedio = jsonElement["TiempoMedio"] as? Int
            let Cooperativo = jsonElement["Cooperativo"] as? Int
            let Valoracion = jsonElement["Valoracion"] as? Double
            
                juego.JuegoMesa = JuegoMesa
                print(JuegoMesa)
                juego.Autor = Autor
                print(Autor)
                juego.TiempoMedio = TiempoMedio
                juego.Cooperativo = Cooperativo
                juego.Valoracion = Valoracion
            
            juegos.add(juego)
        }
        
        // en locations tenemos el resulado de la select
        print(juegos)
    }

}

