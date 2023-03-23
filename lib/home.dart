import 'package:flutter/material.dart';
import 'package:get_data/success.dart';

class HomeSreen extends StatelessWidget {
  static const route_name = "home_screen";
  final form = GlobalKey<FormState>();
  String ip_string = "http://192.168.196.191/";
  String time_interval = "3";

  void saveForm(BuildContext context) {
    bool valid = form.currentState!.validate();

    if (!valid) {
      return;
    }
    form.currentState!.save();

    Navigator.pushNamed(context, SuccessScreen.route_name,
        arguments: {'ip': ip_string, 'time': time_interval});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GET DATA'),
        ),
        body: Form(
            key: form,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text(
                    "Enter the IP Address to Fetch the Data",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'ip address',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    onSaved: (value) {
                      ip_string = value as String;
                    },
                    initialValue: ip_string.toString(),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please provide a value';
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Enter the Interval To Fetch",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text(
                        'enter in sec',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    onSaved: (value) {
                      time_interval = value as String;
                    },
                    initialValue: time_interval,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please provide a value';
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      elevation: MaterialStateProperty.all(8),
                    ),
                    onPressed: () {
                      saveForm(context);
                    },
                    child: const Text(
                      'CONNECT',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            )));
  }
}
