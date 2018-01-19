import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    let informacion:[String] = ["Pandemic", "Gloomhaven", "Agricola"]
    
    
    let subtitulo:[String] = ["Autor 1", "Autor 2", "Autor 3"]
    
    
    let titulo = "Juegos"
    
    var Sections_Arr=[Data]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getFromJSON()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(informacion)
        return informacion.count        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fila = tableView.dequeueReusableCell(withIdentifier: "fila", for: indexPath)
        fila.textLabel?.text = informacion[indexPath.row]
        fila.detailTextLabel?.text = subtitulo[indexPath.row]
        return fila
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titulo
    }

    func getFromJSON() {
        
        let URL = NSURL(string: "http://iesayala.ddns.net/mls/JuegosMesaXcode.php")
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
        let locations = NSMutableArray()
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let location = LocationModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let cod = jsonElement["cod"] as? String,
                let cosa = jsonElement["cosa"] as? String            {
                
                location.cod = cod
                location.cosa = cosa
                
            }
            
            locations.add(location)
            
            
            
        }
        
        // en locations tenemos el resulado de la select
        print(locations)
    }

}

