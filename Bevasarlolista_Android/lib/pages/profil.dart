import 'package:bevasarlolista_android/controller/userController.dart';
import 'package:bevasarlolista_android/model/urlprefix.dart';
import 'package:bevasarlolista_android/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import '../components/menu.dart';

bool isChecked = false;
final ImagePicker _picker = ImagePicker();

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: const Text(
          'Profil',
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: const Menu(),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      image: DecorationImage(
                        image: NetworkImage(
                          '${UserController.loggeduser!.profilpicture!}',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: Colors.green,
                        width: 4.0,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Üdv ${UserController.loggeduser!.fullname!.split(" ")[1]}!",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontSize: 30.0,
                  ),
                ),
                const Divider(
                  height: 40.0,
                  color: Colors.green,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Felhasználónév: ",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${UserController.loggeduser!.name!}",
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Email cím: ",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${UserController.loggeduser!.email!}",
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Regisztáció dátuma: ",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${UserController.loggeduser!.created!.split('T')[0]}",
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Profil törlése kijelentkezéssel:",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(isChecked){
                          await Dio().delete('${UrlPrefix.prefix}/api/felhasznalo/${UserController.loggeduser!.id!}', options: Options(followRedirects: false, validateStatus: (status){
                            return status! < 500;
                          }));
                        }
                        UserController.loggeduser = null;
                        Get.toNamed('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.90, 80.0),
                        primary: Colors.green[600],
                      ),
                      child: const Text(
                        "Kijelentkezés",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
