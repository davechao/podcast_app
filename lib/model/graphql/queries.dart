const String readPodCasts = r'''
  query ReadPodCasts {
    podcast {
      id,
      artistName,
      name,
      artworkUrl100
    }
  }
  ''';

const String readPodCastDetail = r'''
  query ReadPodCastDetail($collectionId: String!) {   
  	collection(id: $collectionId) {
  	  artistId
  	  artistName
  	  artworkUrl100
  	  collectionId
  	  collectionName
  	  country
  	  genreIds
  	  genres
  	  releaseDate
  		contentFeed {
        contentUrl,
        desc,
        publishedDate,
        title
      }
  	}
  }
  ''';
