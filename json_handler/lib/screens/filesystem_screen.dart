import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileSystemScreen extends StatefulWidget {
  const FileSystemScreen({Key? key}) : super(key: key);

  @override
  State<FileSystemScreen> createState() => _FileSystemScreenState();
}

class _FileSystemScreenState extends State<FileSystemScreen> {
  bool loadingPaths = true;
  String? documentsPath;
  String? tempPath;

  @override
  void initState() {
    super.initState();
    getPaths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File System"),
      ),
      body: loadingPaths
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Doc path: ' + documentsPath!,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    'Temp path' + tempPath!,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ),
    );
  }

  Future getPaths() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();

    setState(() {
      documentsPath = docsDir as String;
      tempPath = tempDir as String;
      loadingPaths = false;
    });
  }
}
