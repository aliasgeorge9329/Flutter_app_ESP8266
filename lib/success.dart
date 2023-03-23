import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  static const route_name = "success_screen";

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool isLoading = false;
  bool firsttime = false;
  String output = "";
  Map<String, String> args = {};
  var timer;
  int timer_interval = 3;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  void ShowSnackBarError(String title) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        duration: const Duration(seconds: 8),
        backgroundColor: Colors.red,
      ),
    );
  }

  void getdata(String ip_address) {
    setState(() {
      isLoading = true;
    });

    try {
      http.get(
        Uri.parse(ip_address),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ).then((response) {
        setState(() {
          isLoading = false;
          output = response.body;
        });
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        ShowSnackBarError("Not Able to Connect");
        Navigator.pop(context);
      }).timeout(Duration(seconds: 60));
    } on TimeoutException catch (_) {
      setState(() {
        isLoading = false;
      });
      ShowSnackBarError("Not Reachable");
      Navigator.pop(context);
    }
  }

  Widget build(BuildContext context) {
    if (!firsttime) {
      firsttime = true;
      args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

      String ip_address = args['ip']!;
      timer_interval = int.parse(args['time']!);

      if (ip_address.isNotEmpty) {
        timer = Timer.periodic(Duration(seconds: timer_interval), (_) {
          getdata(ip_address);
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('GET DATA'),
        ),
        body: !isLoading
            ? Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      output,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                        elevation: MaterialStateProperty.all(8),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'DISCONNECT',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
