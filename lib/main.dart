import 'package:flutter/material.dart';
import 'package:movie/utils/routes.dart';
import 'package:movie/bloc/movie_bloc.dart';
import 'package:movie/views/movie_list.dart';
import 'package:movie/views/movie_detail.dart';
import 'package:movie/bloc/bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(Movie());
}

class Movie extends StatelessWidget {
  final MovieBloc movieBloc = MovieBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      bloc: movieBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Movie App',
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme.copyWith(
                  headline1: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0,
                    color: Color(
                      0XFF343A40,
                    ),
                  ),
                  caption: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                    color: Color(
                      0XFF5E6770,
                    ),
                  ),
                ),
          ),
          primaryColor: Color(0XFF00384C),
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          MovieRouter.MOVIE_LIST: (ctx) => MovieList(),
          MovieRouter.MOVIE_DETAIL: (ctx) => MovieDetail(),
        },
      ),
    );
  }
}
