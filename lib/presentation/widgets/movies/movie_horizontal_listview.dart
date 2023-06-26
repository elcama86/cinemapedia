import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Header(
              title: widget.title,
              subTitle: widget.subTitle,
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: _Slide(
                    movie: widget.movies[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Imagen
          SizedBox(
            width: 150.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () => context.push('/movie/${movie.id}'),
                child: FadeInImage(
                  height: 220.0,
                  fit: BoxFit.cover,
                  placeholder:
                      const AssetImage('assets/loaders/bottle-loader.gif'),
                  image: NetworkImage(movie.posterPath),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          //* Titulo
          SizedBox(
            width: 150.0,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),
          //* Año
          SizedBox(
            width: 150.0,
            child: Text(
              HumanFormats.year(movie.releaseDate),
              style: textStyles.bodySmall,
            ),
          ),
          //* Rating
          MovieRating(
            voteAverage: movie.voteAverage,
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Header({
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              onPressed: () {},
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
              ),
              child: Text(subTitle!),
            ),
        ],
      ),
    );
  }
}
