import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var juegos = NSMutableArray()

    let informacion:[String] = ["Pandemic", "Gloomhaven", "Agricola"]
    
    
    let subtitulo:[String] = ["Autor 1", "Autor 2", "Autor 3"]
    
    
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
        fila.textLabel?.text = juegoActual.JuegoMesa
        fila.detailTextLabel?.text = juegoActual.Autor
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
            self.parseJSON(data!)
        }
        task.resume()
        
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let juego = Juego()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let JuegoMesa = jsonElement["JuegoMesa"] as? String,
                let Autor = jsonElement["Autor"] as? String,
                let TiempoMedio = jsonElement["TiempoMedio"] as? Int,
                let Cooperativo = jsonElement["Cooperativo"] as? Int,
                let Valoracion = jsonElement["Valoracion"] as? Double
            {
                
                juego.JuegoMesa = JuegoMesa
                juego.Autor = Autor
                juego.TiempoMedio = TiempoMedio
                juego.Cooperativo = Cooperativo
                juego.Valoracion = Valoracion
                
            }
            
            juegos.add(juego)
            
        }
        
        // en locations tenemos el resulado de la select
        print(juegos)
    }

}

