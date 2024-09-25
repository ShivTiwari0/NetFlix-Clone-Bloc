import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadb/logic/cubit/movie_cubit.dart';
import 'package:quadb/logic/cubit/movie_state.dart';

import 'package:quadb/presentation/search_screen.dart';
import 'package:quadb/presentation/widget/corousel.dart';
import 'package:quadb/presentation/widget/upcomming_movie.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCubit, MovieState>(builder: (context, state) {
      if(state is MovieErrorState && state.movies!.isEmpty  ){
        return const Center(child: Text("An Error Occoured"),);
      }
      if(state is MovieLoadingState && state.movies!.isEmpty){
        return const Center(child: CircularProgressIndicator(),);

      }
        return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/logo.png',
          height: 50,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: () {},
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 27,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          // ,
          CustomCarouselSlider( data: state.movies!,),
               
            const SizedBox(
              height: 20,
            ),  
           
                SizedBox(
                height: 220,width: double.infinity,
                child: UpcomingMovieCard(
               movies: state.movies!, headlineText: 'Now Playing',
                ),
              ),
            
            const SizedBox(
              height: 20,
            ),
             SizedBox(
              height: 220,
              child: UpcomingMovieCard(
              
                headlineText: 'Upcoming Movies', movies: state.movies!.reversed.toList(),
              ),
            ),
          ],
        ),
      ),
    );
      
    },);
  }
}