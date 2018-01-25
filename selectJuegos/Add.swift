
import UIKit

class Add: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //elementos en el scene
    @IBOutlet weak var tf_nombre: UITextField!
    @IBOutlet weak var tf_autor: UITextField!
    @IBOutlet weak var tf_tiempo: UITextField!
    @IBOutlet weak var sw_cooperativo: UISwitch!
    @IBOutlet weak var sd_valoracion: UISlider!
    @IBOutlet weak var pv_propietario: UIPickerView!
    
    //variables-array  del
    var pvArrayPropietarios =  ["Alfon","Mari","Wishlist"]
    var  message : String = ""
    
    //elementos de Luis
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //especificar que nosotros trataremos los valores del pickerview
        self.pv_propietario.dataSource = self
        self.pv_propietario.delegate = self
        
    }
    //nº de elementos q se pueden seleccionar
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //cuantos elementos hay dentro del array, el total del array con la fun count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pvArrayPropietarios.count
    }
    //elemento del array que ha sido seleccionado
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pvArrayPropietarios[row]
    }
    //lo que sucede cuando seleccionas en el picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    @IBAction func Add(_ sender: Any) {
        
        //put the link of the php file here. The php file connects the mysql and swift
        let request = NSMutableURLRequest(url: NSURL(string: "http://iesayala.ddns.net/mls/JuegosMesaXcode.php")! as URL)
        request.httpMethod = "POST"
        
        //interpretar el boton
        var swOn : Bool
        if (sw_cooperativo.isOn){
            swOn = true
        }else{
            swOn = false
        }
        
        //interpretar el picker
        let pickerEscogido = (pvArrayPropietarios[pv_propietario.selectedRow(inComponent: 0)])
        var tablaEscogida : String
        
        switch (pickerEscogido){
        case "Alfon":
            tablaEscogida="JuegosAlfon"
        case "Mari":
            tablaEscogida="JuegosMary"
        default:
            tablaEscogida="JuegosDeseados"
        }
        
        //cogemos los datos escritos y los mandamos
        let postString = "JuegoMesa=\(tf_nombre.text!)&Autor=\(tf_autor.text!)&TiempoMedio=\(tf_tiempo.text!)&Cooperativo=\(swOn)&Valoracion=\(sd_valoracion.value)&Propietario=\(tablaEscogida)"
        print(tf_nombre.text!)
        print(tf_autor.text!)
        print(tf_tiempo.text!)
        print(swOn)
        print(sd_valoracion.value)
        print(tablaEscogida)
        print(pvArrayPropietarios[pv_propietario.selectedRow(inComponent: 0)])
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            // resultado (valor del echo de php)
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            if ((responseString?.isEqual(to: "1")))! {
                self.message = "Añadido"
                
            }
            else {
                self.message = "Error al añadir"
                
            }
        }
        task.resume()
        
        //preparar alert dialog
        let alertController = UIAlertController(title: "Registro", message:
            "Añadido", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        //ejecuta el alert dialog
        self.present(alertController, animated: true, completion: nil)
        
        tf_nombre.text = ""
        tf_autor.text = ""
        tf_tiempo.text = ""
        
        
    }
    
    
    
}
