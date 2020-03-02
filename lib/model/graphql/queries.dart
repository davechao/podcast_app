const String readPodCast = r'''
  query {
    podcast {
      artistId,
      artistUrl,
      genre {
        genreId,
        name,
        url
      },
      id,
      kind
    }
  }
  ''';
