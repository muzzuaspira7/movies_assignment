import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_assignment/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/moviesModel.dart';
import 'login_signup/login.dart';
import 'splashscreen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'MainFont'),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List> fetchApi() async {
    var response =
        await http.get(Uri.parse('https://api.sampleapis.com/movies/comedy'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<MoviesModel> movies =
          data.map((json) => MoviesModel.fromJson(json)).toList();
      print(jsonEncode(data[0]));
      return movies;
      // String jsonData = jsonEncode(data);
      // // Print the JSON data
      // print(jsonData);
      // return data;
    } else {
      print('Error ');
      throw Exception('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavbarWidget(),
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: const Text('Movies App'),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
          future: fetchApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return const Text('No Data');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  MoviesModel movies = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.blue[50],
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  // height: 150,
                                  child: Column(
                                    children: [
                                      // Icon(
                                      //   Icons.arrow_drop_up,
                                      //   size: 60,
                                      // ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_drop_up,
                                          size: 40,
                                        ),
                                      ),
                                      const Text('1'),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          size: 40,
                                        ),
                                      ),
                                      const Text('Votes'),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 140,
                                  height: 130,
                                  child: Image.network(
                                    movies.posterURL,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.network(
                                          'https://m.media-amazon.com/images/M/MV5BMTg4MDk1ODExN15BMl5BanBnXkFtZTgwNzIyNjg3MDE@._V1_SX300.jpg');
                                    },
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 160,
                                        child: Text(
                                          movies.title,
                                          maxLines: 2,
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'genre: ',
                                              style: TextStyle(
                                                color: Colors
                                                    .blueGrey, // Grey color for "general:"
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Action, Adventure',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors
                                                    .black, // Black color for "Movies"
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Director: ',
                                              style: TextStyle(
                                                color: Colors
                                                    .blueGrey, // Grey color for "general:"
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Unknown Guy',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors
                                                    .black, // Black color for "Movies"
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Starring: ',
                                              style: TextStyle(
                                                color: Colors
                                                    .blueGrey, // Grey color for "general:"
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Ana de Armas',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,

                                                color: Colors
                                                    .black, // Black color for "Movies"
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text('Mins| English | 2 Apr'),
                                      const Text(
                                        '137 views| Voted by 1 people',
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                              width: 300,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.blue[100])),
                                  onPressed: () {},
                                  child: const Text('Watch the trailer here')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            }
          }),
    );
  }
}
