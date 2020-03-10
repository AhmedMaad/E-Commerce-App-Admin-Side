class Product {
  //Title, Description, Price, Category, Quantity, Image, Sales Point Location
  int _category;
  int _quantity;
  double _price;
  double _latitude;
  double _longitude;
  String _imageURL;
  String _title;
  String _description;

  void setPrice(double price) => this._price = price;

  void setCategory(int category) => this._category = category;

  void setQuantity(int quantity) => this._quantity = quantity;

  void setLatitude(double latitude) => this._latitude = latitude;

  void setLongitude(double longitude) => this._longitude = longitude;

  void setImageURL(String imageURL) => this._imageURL = imageURL;

  void setTitle(String title) => this._title = title;

  void setDescription(String description) => this._description = description;

  double getPrice() => _price;

  int getCategory() => _category;

  int getQuantity() => _quantity;

  double getLatitude() => _latitude;

  double getLongitude() => _longitude;

  String getImageURL() => _imageURL;

  String getTitle() => _title;

  String getDescription() => _description;
}
