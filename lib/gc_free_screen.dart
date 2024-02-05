import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frb_memory/main.dart';
import 'package:frb_memory/src/rust/api/gc_free_screen_logic.dart';

class GCFreeScreen extends StatefulWidget {
  const GCFreeScreen({super.key});

  @override
  State<GCFreeScreen> createState() => _GCFreeScreenState();
}

class _GCFreeScreenState extends State<GCFreeScreen> {
  final _logic = GcFreeScreenLogic.newGCFreeScreenLogic();

  _GCFreeScreenState() {
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
                'When you press "Back" you will see <GCFreeScreenWidget dispose>.\n\n<drop GCFreeScreenLogic> will be shown after GC. Memory allocated in Rust will be freed',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    debugLog('GCFreeScreenWidget dispose');
    _logic.free();
    super.dispose();
  }
}
