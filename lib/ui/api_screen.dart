import 'package:app/blocs/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blog Posts')),
      body: BlocProvider(
        create: (_) => QuoteBloc()..add(FetchQuote()),
        child: BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            if (state is QuoteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuoteLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Post #${post.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(post.title, style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 6),
                          Text(post.body),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is QuoteError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
