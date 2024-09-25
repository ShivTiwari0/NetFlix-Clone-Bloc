import 'package:flutter/material.dart';
import 'package:quadb/data/model/movie_model.dart';
import 'package:quadb/presentation/detail_screen.dart';

class UpcomingMovieCard extends StatelessWidget {
  final List<MovieModel> movies;
  final String headlineText;

  const UpcomingMovieCard({
    super.key,
    required this.headlineText,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headlineText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
       



          
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie) ,));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      movie.image != null
                          ? movie.image!.original ??
                              'https://static.tvmaze.com/uploads/images/original_untouched/425/1064746.jpg'
                          : 'https://static.tvmaze.com/uploads/images/original_untouched/425/1064746.jpg', // Fallback image if image is null
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder.png', // Local placeholder image in case of a network error
                          fit: BoxFit.fitHeight,
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
