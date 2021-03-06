import Foundation


protocol HomeModel2Protocol: class {
    func itemsDownloaded2(items: NSArray)
}

class HomeModel2: NSObject, URLSessionDataDelegate {
    
    weak var delegate: HomeModel2Protocol!
    //variables
    let urlPathMary = "http://iesayala.ddns.net/mls/NewSelectJuegosMesa.php"
    var jsonResult = NSArray()
    
    //Función para descargar de la base de datos
    func downloadItems() {
        
        let url: URL = URL(string: urlPathMary)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data Mary")
            }else {
                print("info Mary descargada")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    //Función para interpretar el JSON
    func parseJSON(_ data:Data) {
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print(error)
        }
        //variables
        var jsonElement = NSDictionary()
        let juegos = NSMutableArray()
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let juego = Juego()
            
            //the following insures none of the JsonElement values are nil through optional binding
            let JuegoMesa = jsonElement["JuegoMesa"] as? String
            let Autor = jsonElement["Autor"] as? String
            let TiempoMedio = jsonElement["TiempoMedio"] as? String
            let Cooperativo = jsonElement["Cooperativo"] as? String
            let Valoracion = jsonElement["Valoracion"] as? String
            
            juego.JuegoMesa = JuegoMesa
            juego.Autor = Autor
            juego.TiempoMedio = TiempoMedio
            juego.Cooperativo = Cooperativo
            juego.Valoracion = Valoracion
            juegos.add(juego)
        }
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.itemsDownloaded2(items: juegos)
        })
    }
}

