import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../data/sp_helper.dart';
import '../data/session.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  List sessions = [];
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();

  final SPHelper helper = SPHelper();

  @override
  void initState() {
    helper.init().then((value) => updateScreen());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your training sessions'),
      ),
      body: ListView(
        children: getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showSessionDialog(context);
        },
      ),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add a new session'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: txtDescription,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: txtDuration,
                    decoration: const InputDecoration(labelText: 'Duration'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  txtDescription.clear();
                  txtDuration.clear();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: saveSession,
                child: const Text('Save'),
              ),
            ],
          );
        });
  }

  Future saveSession() async {
    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';

    Navigator.of(context).pop();

    await helper.incCounter().then((value) {
      var session = Session(value, today, txtDescription.text,
          int.tryParse(txtDuration.text) ?? 0);

      helper.writeSession(session);

      updateScreen();
    });
  }

  List<Widget> getContent() {
    List<Widget> content = [];

    for (Session session in sessions) {
      content.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          helper.deleteSession(session.id).then((value) => updateScreen());
        },
        child: ListTile(
          title: Text(session.description),
          subtitle: Text('${session.date} - duration: ${session.duration} min'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              helper.deleteSession(session.id).then((value) => updateScreen());
            },
          ),
        ),
      ));
    }

    return content;
  }

  void updateScreen() {
    sessions = helper.getSessions();

    setState(() {});
  }
}
