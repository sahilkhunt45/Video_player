class nVideos {
  final String images;
  final String type;
  final List videos;

  nVideos({
    required this.images,
    required this.type,
    required this.videos,
  });
  factory nVideos.fromJSON(Map json) {
    return nVideos(
      images: json['images'],
      type: json['type'],
      videos: json['videos'],
    );
  }
}
