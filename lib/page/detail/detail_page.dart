import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/detail/detail_bloc.dart';
import 'package:podcastapp/bloc/detail/detail_event.dart';
import 'package:podcastapp/bloc/detail/detail_state.dart';

class DetailPage extends StatefulWidget {
  final String collectionId;

  DetailPage(this.collectionId);

  @override
  State<StatefulWidget> createState() {
    return _DetailState();
  }
}

class _DetailState extends State<DetailPage> {
  DetailBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<DetailBloc>(context);
    bloc.add(FetchPodCastDetail(widget.collectionId));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Detail'),
        ),
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is Success) {
              return Center(
                child: Text('Detail'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
