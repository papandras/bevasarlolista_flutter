import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'main.dart';


class LoginPage extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bevásárlólista'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView (
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: Colors.green[900],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Bejelentkezés",
                          style: TextStyle(
                            letterSpacing: 2.0,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 40.0,
                  color: Colors.white,
                ),
               const Padding(
                 padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                 child: Text(
              'Felhasználó név:',
                   style: TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.bold,
                     fontSize: 20,
                     letterSpacing: 1.5,
                   ),
              ),
               ),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                  child: Text(
                    'Jelszó:',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
            Container(
              margin: const EdgeInsets.fromLTRB(0,20.0,0,0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                  /*Future<http.Response> fetchAlbum() {
                    return http.get(Uri.parse('http://localhost:8881/api/login'));
                  }
                  print(fetchAlbum());*/
                },
                child: const Text(
                    'Bejelentkezés',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[600],
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15),
                ),
              ),
            ),
            const Divider(
              height: 40.0,
              color: Colors.green,
            ),
            ElevatedButton(
              onPressed: () async {
                /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );*/
                try {
                  var response = await Dio().get('http://10.0.2.2:8881/api/listak');
                  print(response);
                } catch (e) {
                  print("Hiba:  $e");
                }
              },
              child: const Text(
                  'Regisztráció',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green[400],
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15),
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
