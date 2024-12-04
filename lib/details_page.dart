import 'package:flutter/material.dart';
import 'package:balancemate/calculator.dart';

class DetailsPage extends StatefulWidget{
  const DetailsPage({super.key});
  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
    @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: 
        SafeArea(child: 
          Padding(padding: const EdgeInsets.all(16), child:
            Column(
              children: [
                const Text("Measurements and Details", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold), textAlign: TextAlign.center, softWrap: true),
                const SizedBox(height: 32), 
                const Text("Telescope Name:", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), softWrap: true),
                Text(Calculator.telescope != null ? "${Calculator.telescope}" : "There is no telescope selected", softWrap: true),
                const SizedBox(height: 16),
                const Text("Telescope Weight:", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), softWrap: true),
                Text(Calculator.telescope != null ? "${Calculator.telescope?.getWeight()}kg" : "There is no telescope selected", softWrap: true),
                const SizedBox(height: 16),
                const Text("Telescope Diameter:", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), softWrap: true),
                Text(Calculator.telescope != null ? "${Calculator.telescope?.getDiameter()}mm" : "There is no telescope selected", softWrap: true),
                const SizedBox(height: 16),
                const Text("Offset from RA axis:", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), softWrap: true),
                Text(Calculator.mount != null ? Calculator.mount?.getDistance() != null ? "${Calculator.mount?.getDistance()}mm" : "There is no given offset for this mount" : "There is no mount selected", softWrap: true,),
                const SizedBox(height: 16),
                const Text("Counterweight Name:", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), softWrap: true),
                Text(Calculator.counterweight != null ? "${Calculator.counterweight?.getName()}" : "There is no counterweight selected", softWrap: true,),
                const SizedBox(height: 16),
                const Text("Counterweight weight:", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), softWrap: true),
                Text(Calculator.counterweight != null ? "${Calculator.counterweight?.getWeight()}kg" : "There is no counterweight selected", softWrap: true,),
                const SizedBox(height: 16),
                const Text("Counterweight Distance:", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold), softWrap: true),
                Text(Calculator.calculateDistance() != null ? "${Calculator.calculateDistance()}mm" : "There is no valid setup!", softWrap: true,)
            ])
          )  
        )
    );
  }
}


