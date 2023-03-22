import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;
import processing.serial.*;

Serial myPort;  // objeto para la comunicación serial
float temperatura = 0;  // variable para la temperatura recibida por el monitor serial
MySQL msql;

void setup() {
   size(400, 300);  // tamaño de la ventana
  textAlign(CENTER);  // alinea el texto al centro de la ventana
  textSize(30);  // tamaño del texto
  fill(0);  // color negro para el texto

   // selecciona el primer puerto serial disponible
  myPort = new Serial(this,"COM3", 9600);  // inicia la comunicación serial
  
}

void draw() {
  background(255);  // fondo blanco

  while (myPort.available() > 0) {  // mientras hayan datos en el puerto serial
    String data = myPort.readStringUntil('\n');  // lee una línea completa del monitor serial
    if (data != null) {  // si se recibió algún dato
      data = data.trim();  // quita los espacios en blanco al inicio y fin de la cadena
      temperatura = float(data);  // convierte el dato recibido en un número flotante
    }
  }

  text("Temperatura: " + temperatura + " °C", width/2, height/2);  // muestra el valor de la temperatura en la ventana
  
  delay(2000);
  
  String user = "root";
  String pass = "PerezF15";
  String database = "Sensor";
  
  msql = new MySQL (this, "localhost", database, user, pass);
  if (msql.connect()) {
    msql.query("INSERT INTO Temperatura (Temp) VALUES (" + temperatura + ");");
    while(msql.next()){
      println(msql.getFloat(2)+ msql.getFloat(""));
  } 
    }
}
