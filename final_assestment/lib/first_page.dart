import 'package:flutter/material.dart';

class myApp extends StatelessWidget {
  const myApp({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '',
      theme: ThemeData(
        //primarySwatch: Colors.green,
      ),
      home: gigPage(),
    );
  }
}

class  gigPage extends StatefulWidget {
  @override
  State<gigPage> createState() => _gigPage();
}

class _gigPage extends State<gigPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Clinet Page"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {

                  },
                      child: Text("Create")),
                  ElevatedButton(onPressed: () {

                  },
                      child: Text("View"))
                ],
              ),
              Text("gig ID"),
              TextFormField(

              ),
              Text("name"),
              TextFormField(

              ),
              Text("Pricing"),
              TextFormField(

              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Gig Created!')),
                      );
                    }
                  },
                  child: const Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}