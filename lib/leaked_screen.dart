import 'package:flutter/material.dart';
import 'package:frb_memory/main.dart';
import 'package:frb_memory/src/rust/api/leaked_screen_logic.dart';

class LeakedScreen extends StatefulWidget {
  const LeakedScreen({super.key});

  @override
  State<LeakedScreen> createState() => _LeakedScreenState();
}

class _LeakedScreenState extends State<LeakedScreen> {
  final _logic = LeakedScreenLogic.newLeakedScreenLogic();

  _LeakedScreenState() {
    _logic.setSink().listen((event) {
      // receive data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaked Screen'),
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
                'When you press "Back" you will see <LeakedScreenWidget dispose> only.\n\nEven if you trigger GC you will never get <drop LeakedScreenLogic> from Rust code and memory allocated in Rust will be leaked.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    debugLog('LeakedScreenWidget dispose');
    super.dispose();
  }
}
