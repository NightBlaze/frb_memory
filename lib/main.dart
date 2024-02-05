import 'package:flutter/material.dart';
import 'package:frb_memory/leaked_screen.dart';
import 'package:frb_memory/gc_free_screen.dart';
import 'package:frb_memory/instant_free_screen.dart';
import 'package:frb_memory/src/rust/api/simple.dart';
import 'package:frb_memory/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  createLogStream().listen((message) {
    debugLog(message);
  });
  runApp(const MyApp());
}

debugLog(String message) {
  print(message);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
          body: Center(
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text('Open Leaked Screen'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LeakedScreen(),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Open GC Free Screen'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GCFreeScreen(),
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Open Instant Free Screen'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InstantFreeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
