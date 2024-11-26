import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylers_in_customer/consts/app_icons.dart';
import 'package:stylers_in_customer/model/search/search_model.dart';
import 'package:stylers_in_customer/model/search/search_res_model.dart';
import 'package:stylers_in_customer/network/post_requests.dart';
import 'package:stylers_in_customer/utils/enums/search_cell_type.dart';
import '../../consts/app_consts.dart';
import '../../model/login/login_res_model.dart';
import '../../utils/enums/search_type.dart';

class SearchController extends GetxController {
  var searchTextController = TextEditingController();
  Worker? searchTextChangeListenerWorker;
  RxBool isLoading = false.obs;

  List<String> chipOptions = ['All', 'Stylists', 'Shops', 'Services'];
  RxInt selectedChipIndex = 0.obs;
  SearchType selectedSearchType = SearchType.all;
  RxBool isShowTrailing = true.obs;

  var searchItems = <SearchModel>[].obs;
  var searchItemsFilter = <SearchModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    setupSearchTextChangeListener();
    getSearchKeyword();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchTextChangeListenerWorker?.dispose();
    super.onClose();
  }

  getSearchKeyword() {
    Map? data = Get.arguments;

    if (data != null && data.containsKey(AppConsts.keySearchKeyword)) {
      searchTextController.text = data[AppConsts.keySearchKeyword];
    }
  }

  setupSearchTextChangeListener() {
    RxString searchText = ''.obs;
    searchTextChangeListenerWorker = debounce(searchText,
        (callback) => fetchSearchResults(searchText.value, selectedSearchType));

    searchTextController.addListener(() {
      searchText.value = searchTextController.text.toString().trim();
    });
  }

  fetchSearchResults(String searchText, SearchType searchType) async {
    isLoading.value = true;
    var response = await PostRequests.searchText(searchText, searchType);
    isLoading.value = false;
    if (response != null) {
      if (response.success) {
        feedSearchData(response.data!);
      } else {
        // Get.snackbar('error'.tr, response.message);
      }
    } else {
      Get.snackbar('error'.tr, 'message_server_error'.tr);
    }
    // if (AppFormatters.validEmailExp.hasMatch(email)) {
    //   isEmailExist.value =
    //       await PostRequests.checkUserExist(UserExistCheckType.email, email);
    //   if (isEmailExist.value) {
    //     isShowEmailExistTip.value = true;
    //   } else {
    //     isShowEmailExistTip.value = false;
    //   }
    //   isShowEmailExistTip.refresh();
    // }
  }

  onSearchTextChange(String text) {}

  onChipTap(int index) {
    if (selectedChipIndex.value != 0 && index == 0) {
      fetchSearchResults(searchTextController.text, SearchType.all);
    }
    selectedChipIndex.value = index;

    switch (index) {
      case 0:
        selectedSearchType = SearchType.all;
        searchItemsFilter.assignAll(searchItems);
        break;
      case 1:
        selectedSearchType = SearchType.stylist;
        searchItemsFilter.assignAll(searchItems.where((element) =>
            element.header == chipOptions[1] ||
            element.cellType == SearchCellType.stylistsList));
        break;

      case 2:
        selectedSearchType = SearchType.shop;
        searchItemsFilter.assignAll(searchItems.where((element) =>
            element.header == chipOptions[2] ||
            element.cellType == SearchCellType.shopList));
        break;

      case 3:
        selectedSearchType = SearchType.service;
        searchItemsFilter.assignAll(searchItems.where((element) =>
            element.header == chipOptions[3] ||
            element.cellType == SearchCellType.serviceGrid));
        break;
      default:
        searchItemsFilter.assignAll(searchItems);
        break;
    }
  }

  onBackTap() {
    Get.back();
  }

  feedSearchData(SearchResult searchResult) {
    var stylistsList = searchResult.stylists;
    var shopList = searchResult.shops;
    var serviceList = searchResult.service;


    searchItems.clear();
    if (stylistsList != null && stylistsList.isNotEmpty) {
      searchItems.add(
          SearchModel(cellType: SearchCellType.header, header: chipOptions[1]));
      searchItems.add(SearchModel<dynamic>(
          cellType: SearchCellType.stylistsList, list: stylistsList));
    }
    if (shopList != null && shopList.isNotEmpty) {
      searchItems.add(
          SearchModel(cellType: SearchCellType.header, header: chipOptions[2]));
      searchItems.add(
          SearchModel<Provider>(cellType: SearchCellType.shopList, list: shopList));
    }
    if (serviceList != null && serviceList.isNotEmpty) {
      searchItems.add(
          SearchModel(cellType: SearchCellType.header, header: chipOptions[3]));
      searchItems.add(SearchModel<Service>(
          cellType: SearchCellType.serviceGrid, list: serviceList));
    }
    searchItemsFilter.clear();
    onChipTap(selectedChipIndex.value);
  }

  onTapClose() {
    searchTextController.clear();
    searchItems.clear();
    searchItemsFilter.clear();
    isShowTrailing.value = false;
  }
}
