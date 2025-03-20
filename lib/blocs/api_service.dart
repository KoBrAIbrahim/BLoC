import 'package:app/model/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class QuoteEvent {}

class FetchQuote extends QuoteEvent {}

abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final List<Post> posts;
  QuoteLoaded(this.posts);
}

class QuoteError extends QuoteState {
  final String message;
  QuoteError(this.message);
}


class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteInitial()) {
    on<FetchQuote>((event, emit) async {
      emit(QuoteLoading());
      try {
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as List;
          final posts = data.map((json) => Post.fromJson(json)).toList();
          emit(QuoteLoaded(posts));
        } else {
          emit(QuoteError('Failed to load posts'));
        }
      } catch (e) {
        emit(QuoteError('Something went wrong'));
      }
    });
  }
}
