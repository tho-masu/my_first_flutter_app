import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const _url = 'https://flutter.dev/';

const mApp = ElevatedButton(
  onPressed: launchURL,
  child: Text('Show Flutter homepage'),
);

void launchURL({String url = _url}) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

Future<String> request(String url) async {
  Uri uri = Uri.parse(url);
  http.Response res = await http.get(uri);
  return res.body;
}
