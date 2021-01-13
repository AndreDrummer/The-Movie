class MovieDetailsModel {
  int id;
  bool video;
  bool adult;
  int budget;
  int revenue;
  int runtime;
  String title;
  String imdbId;
  String status;
  int voteCount;
  String tagline;
  String overview;
  String homepage;
  Credits credits;
  double popularity;
  String posterPath;
  String releaseDate;
  double voteAverage;
  List<Genres> genres;
  String backdropPath;
  String originalTitle;
  String originalLanguage;
  List<SpokenLanguages> spokenLanguages;
  BelongsToCollection belongsToCollection;
  List<ProductionCompanies> productionCompanies;
  List<ProductionCountries> productionCountries;

  MovieDetailsModel({
    this.id,
    this.video,
    this.title,
    this.adult,
    this.budget,
    this.status,
    this.runtime,
    this.imdbId,
    this.genres,
    this.tagline,
    this.revenue,
    this.credits,
    this.overview,
    this.homepage,
    this.voteCount,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
    this.backdropPath,
    this.originalTitle,
    this.spokenLanguages,
    this.originalLanguage,
    this.belongsToCollection,
    this.productionCompanies,
    this.productionCountries,
  });

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    video = json['video'];
    adult = json['adult'];
    status = json['status'];
    budget = json['budget'];
    imdbId = json['imdb_id'];
    tagline = json['tagline'];
    runtime = json['runtime'];
    revenue = json['revenue'];
    overview = json['overview'];
    homepage = json['homepage'];
    voteCount = json['vote_count'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    voteAverage = json['vote_average'];
    releaseDate = json['release_date'];
    backdropPath = json['backdrop_path'];
    originalTitle = json['original_title'];
    originalLanguage = json['original_language'];
    credits = json['credits'] != null ? new Credits.fromJson(json['credits']) : null;
    belongsToCollection = json['belongs_to_collection'] != null ? new BelongsToCollection.fromJson(json['belongs_to_collection']) : null;

    if (json['production_companies'] != null) {
      productionCompanies = new List<ProductionCompanies>();
      json['production_companies'].forEach((v) {
        productionCompanies.add(new ProductionCompanies.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = new List<ProductionCountries>();
      json['production_countries'].forEach((v) {
        productionCountries.add(new ProductionCountries.fromJson(v));
      });
    }
    if (json['spoken_languages'] != null) {
      spokenLanguages = new List<SpokenLanguages>();
      json['spoken_languages'].forEach((v) {
        spokenLanguages.add(new SpokenLanguages.fromJson(v));
      });
    }

    if (json['genres'] != null) {
      genres = new List<Genres>();
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['video'] = this.video;
    data['adult'] = this.adult;
    data['budget'] = this.budget;
    data['status'] = this.status;
    data['imdb_id'] = this.imdbId;
    data['revenue'] = this.revenue;
    data['tagline'] = this.tagline;
    data['runtime'] = this.runtime;
    data['overview'] = this.overview;
    data['homepage'] = this.homepage;
    data['vote_count'] = this.voteCount;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['vote_average'] = this.voteAverage;
    data['backdrop_path'] = this.backdropPath;
    data['original_title'] = this.originalTitle;
    data['original_language'] = this.originalLanguage;
    if (this.credits != null) {
      data['credits'] = this.credits.toJson();
    }
    if (this.productionCountries != null) {
      data['production_countries'] = this.productionCountries.map((v) => v.toJson()).toList();
    }
    if (this.belongsToCollection != null) {
      data['belongs_to_collection'] = this.belongsToCollection.toJson();
    }
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    if (this.spokenLanguages != null) {
      data['spoken_languages'] = this.spokenLanguages.map((v) => v.toJson()).toList();
    }
    if (this.productionCompanies != null) {
      data['production_companies'] = this.productionCompanies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BelongsToCollection {
  int id;
  String name;
  String posterPath;
  String backdropPath;

  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster_path'] = this.posterPath;
    data['backdrop_path'] = this.backdropPath;
    return data;
  }
}

class Genres {
  int id;
  String name;

  Genres({
    this.id,
    this.name,
  });

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ProductionCompanies {
  int id;
  String name;
  String logoPath;
  String originCountry;

  ProductionCompanies({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logoPath = json['logo_path'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo_path'] = this.logoPath;
    data['origin_country'] = this.originCountry;
    return data;
  }
}

class ProductionCountries {
  String name;
  String iso31661;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iso31661 = json['iso_3166_1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iso_3166_1'] = this.iso31661;
    return data;
  }
}

class SpokenLanguages {
  String name;
  String iso6391;
  String englishName;

  SpokenLanguages({
    this.englishName,
    this.iso6391,
    this.name,
  });

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iso6391 = json['iso_639_1'];
    englishName = json['english_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iso_639_1'] = this.iso6391;
    data['english_name'] = this.englishName;
    return data;
  }
}

class Credits {
  List<Cast> cast;
  List<Crew> crew;

  Credits({
    this.cast,
    this.crew,
  });

  Credits.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = new List<Cast>();
      json['cast'].forEach((v) {
        cast.add(new Cast.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = new List<Crew>();
      json['crew'].forEach((v) {
        crew.add(new Crew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cast != null) {
      data['cast'] = this.cast.map((v) => v.toJson()).toList();
    }
    if (this.crew != null) {
      data['crew'] = this.crew.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cast {
  int id;
  int order;
  bool adult;
  int castId;
  int gender;
  String name;
  String creditId;
  String character;
  double popularity;
  String profilePath;
  String originalName;
  String knownForDepartment;

  Cast({
    this.id,
    this.name,
    this.order,
    this.adult,
    this.gender,
    this.castId,
    this.creditId,
    this.character,
    this.popularity,
    this.profilePath,
    this.originalName,
    this.knownForDepartment,
  });

  Cast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    adult = json['adult'];
    gender = json['gender'];
    castId = json['cast_id'];
    creditId = json['credit_id'];
    character = json['character'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    originalName = json['original_name'];
    knownForDepartment = json['known_for_department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['adult'] = this.adult;
    data['order'] = this.order;
    data['gender'] = this.gender;
    data['cast_id'] = this.castId;
    data['credit_id'] = this.creditId;
    data['character'] = this.character;
    data['popularity'] = this.popularity;
    data['profile_path'] = this.profilePath;
    data['original_name'] = this.originalName;
    data['known_for_department'] = this.knownForDepartment;
    return data;
  }
}

class Crew {
  int id;
  int gender;
  bool adult;
  String job;
  String name;
  String creditId;
  double popularity;
  String department;
  String profilePath;
  String originalName;
  String knownForDepartment;

  Crew({
    this.id,
    this.name,
    this.job,
    this.adult,
    this.gender,
    this.creditId,
    this.popularity,
    this.department,
    this.profilePath,
    this.originalName,
    this.knownForDepartment,
  });

  Crew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = json['job'];
    name = json['name'];
    adult = json['adult'];
    gender = json['gender'];
    creditId = json['credit_id'];
    popularity = json['popularity'];
    department = json['department'];
    profilePath = json['profile_path'];
    originalName = json['original_name'];
    knownForDepartment = json['known_for_department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job'] = this.job;
    data['name'] = this.name;
    data['adult'] = this.adult;
    data['gender'] = this.gender;
    data['credit_id'] = this.creditId;
    data['popularity'] = this.popularity;
    data['department'] = this.department;
    data['profile_path'] = this.profilePath;
    data['original_name'] = this.originalName;
    data['known_for_department'] = this.knownForDepartment;
    return data;
  }
}
