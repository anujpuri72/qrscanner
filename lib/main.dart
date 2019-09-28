import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: fscreen(),
      
    );
  }
}
class fscreen extends StatefulWidget {
  
  @override
  _fscreenState createState() => _fscreenState();
}

class _fscreenState extends State<fscreen> {

  String id ="201851025";
  Future _scanqr() async{
    try{
      String result = await BarcodeScanner.scan();
      setState(() {
        id=result;
      });
    } on PlatformException catch (e){
      if(e.code == BarcodeScanner.CameraAccessDenied)
      {setState(() {
        id ="camera permission denied";
      });
    } else{
      setState(() {
        id="an error occured $e";
      });
    }
  } on FormatException{
    setState(() {
      id=" back button pressed";
    });
  } catch (e){
    setState(() {
        id="an error occured $e";
      });

  }
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hi $id",style: TextStyle(fontStyle: FontStyle.italic),),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        icon: Icon(Icons.camera),
        label: Text("Scan me"),
        onPressed: _scanqr,
        tooltip: "scan code",
      ),
      
    );
  }
}