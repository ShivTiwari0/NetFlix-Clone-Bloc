import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quadb/data/model/movie_model.dart';
import 'package:quadb/presentation/detail_screen.dart';
import 'package:quadb/presentation/widget/landing_card.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({
    super.key,
    this.data,
  });
  final List<MovieModel>? data;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var carouselOptions = CarouselOptions(
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      aspectRatio: 16 / 9,
      viewportFraction: 0.9,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    );
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
        itemCount: data!.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          String url = data![index].image != null
              ? data![index].image!.original.toString()
              : 'https://static.tvmaze.com/uploads/images/original_untouched/425/1064746.jpg';
          return GestureDetector(
            onTap: () {  Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: data![index]) ,));},
            child: LandingCard(
              image: CachedNetworkImageProvider(url),
              name: data![index].name.toString(),
            ),
          );
        },
        options: carouselOptions,
      ),
    );
  }
}
