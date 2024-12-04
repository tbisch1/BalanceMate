import 'package:balancemate/calculator.dart';
import 'package:flutter/material.dart';
import 'package:balancemate/database_manager.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});
  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  //I list the options here so they can be modified for database connection
  List<DropdownMenuEntry> telescopeOptions = [];
  List<DropdownMenuEntry> mountOptions = [];
  List<DropdownMenuEntry> counterweightOptions = [];
  Telescope? initialTelescope;
  Mount? initialMount;
  dynamic initialCounterweight; //is dynamic because it is either a Counterweight or a CounterweightSetup or null

  bool _dataLoaded = false;
  @override void initState() {
    super.initState();
    _loadData().then((_) {
      setState(() {
        _dataLoaded = true;
      });
    });
  }
  Future<void> _loadData() async {
    var db = DatabaseManager();
    await db.init();
    await _loadTelescopes(db);
    await _loadMounts(db);
    await _loadCounterweights(db);
  }
  Future<void> _loadTelescopes(DatabaseManager db) async {
    var telescopes = await db.getTelescopes();
    for (var telescope in telescopes) {
      setState(() {
        telescopeOptions.add(DropdownMenuEntry(value: telescope, label: telescope.toString()));
      });
    }
    if (Calculator.telescope != null) {
      for (var i in telescopeOptions) {
        if (i.value == Calculator.telescope) {
          // print('Found ${i.value}');
          // print(i.runtimeType);
          setState(() {
            initialTelescope = i.value;
          });
          break;
        }
      }
    }
  }

  Future<void> _loadMounts(DatabaseManager db) async {
    var mounts = await db.getMounts();
    for (var mount in mounts) {
      mountOptions.add(DropdownMenuEntry(value: mount, label: mount.toString()));
    }
    if (Calculator.mount != null) {
      for (var i in mountOptions) {
        if (i.value == Calculator.mount) {
          setState(() {
            initialMount = i.value;
          });
          break;
        }
      }
    }
  }

  Future<void> _loadCounterweights(DatabaseManager db) async {
    List<Counterweight> counterweights = await db.getCounterweights();
    List<CounterweightSetup> counterweightSetups = await db.getCounterweightSetups();
    for (CounterweightSetup counterweightSetup in counterweightSetups) {
      counterweightOptions.add(DropdownMenuEntry(value: counterweightSetup, label: counterweightSetup.toString()));
    }
    for (Counterweight counterweight in counterweights) {
      counterweightOptions.add(DropdownMenuEntry(value: counterweight, label: counterweight.toString()));
    }
    if (Calculator.counterweight != null) {
      for (var i in counterweightOptions) {
        if (i.value == Calculator.counterweight) {
          setState(() {
            initialCounterweight = i.value;
          });
          break;
        }
      }
    }
  }

  void _setTelescope(dynamic telescope) {
    if (telescope is Telescope) {
      Calculator.telescope = telescope;
    }
    // print(Calculator.telescope);
    // print(Calculator.calculateDistance());
  }
  void _setMount(dynamic mount) {
    if (mount is Mount) {
      Calculator.mount = mount;
    }

    // print(Calculator.mount);
  }
  void _setCounterweightSetup(dynamic counterweightSetup) {
    if (counterweightSetup is Counterweight || counterweightSetup is CounterweightSetup) {
      Calculator.counterweight = counterweightSetup;
    }
    // print(Calculator.counterweight);
  }

  @override
  Widget build(BuildContext context) {
    

    // List<Currency> currencies = [
    //   Currency(code: 'USD'),
    //   Currency(code: 'EUR'),
    //   Currency(code: 'AED'),
    //   Currency(code: 'BTC'),
    //   Currency(code: 'SOL'),
    // ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _dataLoaded
              ? Center(
                  child: Column(
                    children: [
                      const Text("Telescope Selection", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 32),
                      DropdownMenu(initialSelection: initialTelescope, dropdownMenuEntries: telescopeOptions, onSelected: _setTelescope),
                      const SizedBox(height: 80),
                      const Text("Mount Selection", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 32),
                      DropdownMenu(initialSelection: initialMount, dropdownMenuEntries: mountOptions, onSelected: _setMount,),
                      const SizedBox(height: 80),
                      const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text("Counterweight Setup", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        // const SizedBox(width: 32),
                        // ElevatedButton(onPressed: (){}, child: const Text("+")) //Will open a page to input custom counterweight information
                      ]),
                      const SizedBox(height: 32),
                      DropdownMenu(initialSelection: initialCounterweight, dropdownMenuEntries: counterweightOptions, onSelected: _setCounterweightSetup,),
                      //TODO: Consider adding a button to initiate the calculations here

                    //   DropdownMenu(
                    //   initialSelection: currencies[0],
                    //   dropdownMenuEntries: [
                    //     for (var currency in currencies)
                    //       DropdownMenuEntry(
                    //         label: currency.code,
                    //         value: currency
                    //       )
                    //   ]
                    // )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

// class Currency {
//       final String code;

//       Currency({
//         required this.code
//       });
//     }