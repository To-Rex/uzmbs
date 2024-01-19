import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uzmbs/bottomBar/chek.dart';
import 'package:uzmbs/bottomBar/export.dart';
import 'package:uzmbs/bottomBar/import.dart';
import 'package:uzmbs/models/code_model.dart';
import 'package:uzmbs/models/company_model.dart';
import 'package:uzmbs/models/currency_model.dart';

import '../models/part_model.dart';
import '../models/product_in_warehouse.dart';
import '../models/unito_of_measure.dart';

class GetController extends GetxController {
  var fullName = 'Dilshodjon Haydarov'.obs;
  var widgetOptions = <Widget>[];
  var index = 0.obs;
  var selectedDropDown = 0.obs;

  var productInWarehouse = <ProductInWarehouse>[].obs;
  var currencyModel = <CurrencyModel>[].obs;
  var unitOfMeasure = <UnitOfMeasure>[].obs;
  var companyModel = <Company>[].obs;
  var partModel = <Part>[].obs;
  var codeModel = <Code>[].obs;

  //change productInWarehouse
  void changeProductInWarehouse(List<ProductInWarehouse> productInWarehouse) {
    this.productInWarehouse.value = productInWarehouse;
  }

  //change currencyModel
  void changeCurrencyModel(List<CurrencyModel> currencyModel) {
    this.currencyModel.value = currencyModel;
  }

  //change unitOfMeasure
  void changeUnitOfMeasure(List<UnitOfMeasure> unitOfMeasure) {
    this.unitOfMeasure.value = unitOfMeasure;
  }

  //change companyModel
  void changeCompanyModel(List<Company> companyModel) {
    this.companyModel.value = companyModel;
  }

  //change partModel
  void changePartModel(List<Part> partModel) {
    this.partModel.value = partModel;
  }

  //change codeModel
  void changeCodeModel(List<Code> codeModel) {
    this.codeModel.value = codeModel;
  }

  void changeWidgetOptions() {
    widgetOptions.add(ImportPage());
    widgetOptions.add(ExportPage());
    widgetOptions.add(CheckPage());
  }

  void changeIndex(int index) {
    this.index.value = index;
  }

  void changeSelectedDropDown(int selectedDropDown) {
    this.selectedDropDown.value = selectedDropDown;
  }
}