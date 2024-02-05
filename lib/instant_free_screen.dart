import 'package:flutter/material.dart';
import 'package:frb_memory/main.dart';
import 'package:frb_memory/src/rust/api/instant_free_screen_logic.dart';

class InstantFreeScreen extends StatefulWidget {
  const InstantFreeScreen({super.key});

  @override
  State<InstantFreeScreen> createState() => _InstantFreeScreenState();
}

class _InstantFreeScreenState extends State<InstantFreeScreen> {
  final _logic = InstantFreeScreenLogic.newInstantFreeScreenLogic();

  _InstantFreeScreenState() {
    _logic.setSink().listen((event) {
      // receive data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GC Free Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                child: const Text('Allocate memory'),
                onPressed: () {
                  _logic.allocateMemory();
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'When you press "Back" you will see both <InstantFreeScreenWidget dispose> and <drop InstantFreeScreenLogic>. Memory allocated in Rust will be freed',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    debugLog('InstantFreeScreenWidget dispose');
    _logic.dispose();
    super.dispose();
  }
}
