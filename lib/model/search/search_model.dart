import 'package:stylers_in_customer/utils/enums/search_cell_type.dart';

class SearchModel<T> {
  SearchCellType cellType;
  String? header;
  List<T>? list;

  SearchModel({required this.cellType, this.list, this.header});
}

// class StylistsModel {
//   String? title;
//
//   StylistsModel({this.title});
// }
//
// class ShopModel {
//   String? title;
//
//   ShopModel({this.title});
// }

// class ServiceModel {
//   String? title;
//
//   ServiceModel({this.title});
// }

// class ServiceModel {
//   ServiceModel({
//     required this.id,
//     this.name,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   int id;
//   String? name;
//   String? image;
//   DateTime? createdAt;
//   DateTime? updatedAt;
// }
