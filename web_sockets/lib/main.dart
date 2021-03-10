import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:http/http.dart' as http;

// substitute your server's IP and port
String YOUR_SERVER_IP = '192.168.0.230';
String YOUR_SERVER_PORT = '8000';
String URL = 'ws://$YOUR_SERVER_IP:$YOUR_SERVER_PORT';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FauxLoginPage(),
    );
  }
}

class FauxLoginPage extends StatelessWidget {
  final TextEditingController controller =
      TextEditingController(text: "$YOUR_SERVER_IP:$YOUR_SERVER_PORT");

  void goToMainPage(String url, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnnouncementPage("ws://" + url)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Escolhe IP:Porta")),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "URL"),
              onSubmitted: (url) => goToMainPage(url, context),
            ),
            TextButton(
                onPressed: () => goToMainPage(controller.text, context),
                child: Text("Connect"))
          ],
        ),
      ));
}

class AnnouncementPage extends StatefulWidget {
  AnnouncementPage(this.url);

  String url;

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  IOWebSocketChannel channel =
      IOWebSocketChannel.connect(Uri.encodeFull(URL.toString()));

  final TextEditingController controller =
      TextEditingController(text: "testeTrama");

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(Uri.encodeFull(URL.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comunication Page"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Text(snapshot.data.toString(),
                      style: TextStyle(fontSize: 40))
                  : CircularProgressIndicator();
            },
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "Enter your message here"),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () {
            channel.sink.add("${controller.text}");
          }),
    );
  }
}
