import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:quadb/data/model/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieModel movie; // Accepting MovieModel as an argument

  const MovieDetailScreen({super.key, required this.movie}); // Updated constructor

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(movie.image!.original??'https://static.tvmaze.com/uploads/images/original_untouched/425/1064746.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.name!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        movie.premiered.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        movie.genres!.map((genre) => genre).join(', '),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                      ),
                        const SizedBox(width: 30),Text( movie.runtime !=null?
                      '${movie.runtime.toString()} minutes': '124 minutes',
                        style: const TextStyle(    
                          color: Colors.grey,
                        ),
                      ), const SizedBox(width: 30),Text( movie.runtime !=null?
                        movie.language.toString(): 'Hindi',
                        style: const TextStyle(   
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    movie.summary!,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
   
            const Text(
              "More like this",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
     
            const Text("Recommendations will be displayed here."),
          ],
        ),
      ),
    );
  }
}
