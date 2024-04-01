import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'session.dart';
import 'dart:convert';

class SPHelper {
  static late SharedPreferences _prefs;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future writeSession(Session session) async {
    await _prefs.setString(
        session.id.toString(), json.encode(session.toJson()));
  }

  List<Session> getSessions() {
    List<Session> sessions = [];

    Set<String> keys = _prefs.getKeys();

    for (String key in keys) {
      if (key != 'counter') {
        var session = _prefs.getString(key);
        if (session != null) {
          sessions.add(Session.fromJson(json.decode(session)));
        }
      }
    }

    return sessions;
  }

  Future<int> incCounter() async {
    int counter = _prefs.getInt('counter') ?? 0;

    counter++;

    await _prefs.setInt('counter', counter);

    return counter;
  }

  Future deleteSession(int id) async {
    await _prefs.remove(id.toString());
  }
}
