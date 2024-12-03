import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget{
  const DetailsPage({super.key});
  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: 
        const SafeArea(child: 
          Padding(padding: EdgeInsets.all(16), child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Measurements and Details", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                SizedBox(height: 16), 
                Text("Telescope"),
                SizedBox(height: 16), 
                Text("Mount Weight"),
                SizedBox(height: 16), 
                Text("Counterweight weight"),
                SizedBox(height: 16), 
                Text("How far from Mount point"),
                SizedBox(height: 16)
              ],
            )
          )  
        ),



      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setup'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Details'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[700],
        onTap: _onItemTapped,
      ),
    );
  }
}
