import Foundation


protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
   
    weak var delegate: HomeModelProtocol!
    
    let urlPath = "http://iesayala.ddns.net/mls/SelectJuegosMesa.php"
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
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
        let juegos = NSMutableArray()
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
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: locations)
            
        })
    }
}
