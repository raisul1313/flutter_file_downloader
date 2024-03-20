import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Example1 extends StatefulWidget {
  const Example1({super.key});

  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1> {

  double progress = 0;

  ReceivePort _receivePort = ReceivePort();

  @override
  void initState() {
    super.initState();

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  static downloadingCallback(id, status, progress) {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              value: progress,
              minHeight: 5,
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  final status = await Permission.storage.request();
                  if (status.isGranted) {
                    final externalDirectory =
                        await getExternalStorageDirectory();
                    final id = await FlutterDownloader.enqueue(
                        url:
                            'http://103.92.85.239/storage/files/uploads/attachments/28_02_2024/p9ISFOW4tmfuXphwBEUoqYAEkQRQyV4p6Lqq9Ve6.pdf',
                        savedDir: externalDirectory!.path,
                        fileName: 'contract.pdf',
                        showNotification: true,
                        openFileFromNotification: true);
                  } else {
                    print('Permission Denied');
                  }
                },
                child: const Text('Download'))
          ],
        ),
      ),
    );
  }
}
