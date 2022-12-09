class BookModel {
  BookModel(this.title, this.image, this.description,
      {this.soundcloud, this.youTubeLink,this.pdfPath,});

  final String title;
  final String image;
  final String? pdfPath;
  final String description;
  final String? soundcloud;
  final String? youTubeLink;
}
