import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:path_provider/path_provider.dart';

class AudioProcessor {
  Isolate? _audioProcessingIsolate;
  final ReceivePort _receivePort = ReceivePort();
  late SendPort _sendPort;

  Future<void> startAudioProcess(String url) async {
    // Start the isolate and pass the ReceivePort for communication
    _audioProcessingIsolate =
        await Isolate.spawn(_audioProcessingEntryPoint, _receivePort.sendPort);

    // Listen for messages from the isolate
    _receivePort.listen((message) {
      if (message is Map<String, dynamic>) {
        // Handle the result received from the isolate
        _handleAudioProcessingResult(message);
      }
    });

    // Send the URL to the isolate for processing
    _sendPort = await _initializeIsolate(url);
  }

  // Initialize the isolate and send the initial message
  Future<SendPort> _initializeIsolate(String url) async {
    final completer = Completer<SendPort>();
    final receivePort = ReceivePort();

    // Send the receivePort to the isolate to get the SendPort back
    _audioProcessingIsolate!.addOnExitListener(receivePort.sendPort);
    receivePort.listen((message) {
      completer.complete(message);
    });

    // Send the URL to the isolate to begin processing
    _sendPort.send({'url': url, 'port': receivePort.sendPort});

    return await completer.future;
  }

  void _audioProcessingEntryPoint(SendPort initialSendPort) async {
    final receivePort = ReceivePort();
    initialSendPort.send(receivePort.sendPort);

    await for (var message in receivePort) {
      final String url = message['url'];
      final SendPort sendPort = message['port'];

      //Perform audio file processing here
      final tempPath = await _getTemporaryPath();
      final fileName = url.split('/').last;
      final newFilePath = '$tempPath/$fileName';

      final file = await di.get<BaseCacheManager>().getSingleFile(url);
      await file.copy(newFilePath);

      if (File(newFilePath).existsSync()) {
        final samples = _getSamplesForWidth();
        final waveformData = await _extractWaveformData(newFilePath);

        // Send the result back to the main thread
        sendPort.send({
          'samples': samples,
          'waveformData': waveformData,
          'maxDuration': 120, // Example value for max duration
        });
      } else {
        sendPort.send({'error': 'File does not exist at path: $newFilePath'});
      }
    }
  }

  Future<String> _getTemporaryPath() async {
    final tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  Future<List<int>> _extractWaveformData(String path) async {
    // Example method to extract waveform data
    return List<int>.generate(
        100, (index) => index); // Generate dummy waveform data
  }

  int _getSamplesForWidth() {
    // Example method for getting samples for audio visualization
    return 100; // Return a sample value based on your requirement
  }

  // Handle the result received from the isolate
  void _handleAudioProcessingResult(Map<String, dynamic> result) {
    if (result.containsKey('error')) {
    } else {
      // final samples = result['samples'];
      // final waveformData = result['waveformData'];
      // final maxDuration = result['maxDuration'];
    }
  }

  // Clean up the isolate when no longer needed
  Future<void> dispose() async {
    if (_audioProcessingIsolate != null) {
      _audioProcessingIsolate!.kill(priority: Isolate.immediate);
    }
  }
}
