class ApiProvider {

  String fetchPodCast = """
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
  """;

}
