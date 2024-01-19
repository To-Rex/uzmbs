import 'package:get/get.dart';
import '../main.dart';
import '../models/code_model.dart';
import '../models/company_model.dart';
import '../models/currency_model.dart';
import '../models/part_model.dart';
import '../models/product_in_warehouse.dart';
import '../models/unito_of_measure.dart';
import 'getController.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());

  Future<bool> getCurrency(context) async {
    final response = await supabase.from('currency').select('*');
    final List<CurrencyModel> currency =
    response.map((e) => CurrencyModel.fromJson(e)).toList();
    _getController.changeCurrencyModel(currency);
    return true;
    }

  Future<bool> getCompany(context) async {
    final response = await supabase.from('company').select('*');
    final List<Company> company =
    response.map((e) => Company.fromJson(e)).toList();
    _getController.changeCompanyModel(company);
    return true;
    }

  Future<bool> getUnitOfMeasure(context) async {
    final response = await supabase.from('unit_of_measure').select('*');
    final List<UnitOfMeasure> unitOfMeasure =
    response.map((e) => UnitOfMeasure.fromJson(e)).toList();
    _getController.changeUnitOfMeasure(unitOfMeasure);
    return true;
    }

  Future<bool> getProductInWarehouse(context) async {
    final response = await supabase.from('product_in_warehouse').select('*');
    final List<ProductInWarehouse> productInWarehouse =
    response.map((e) => ProductInWarehouse.fromJson(e)).toList();
    _getController.changeProductInWarehouse(productInWarehouse);
    return true;
    }

  //get code model
  Future<bool> getCode(context) async {
    final response = await supabase.from('code').select('*');
    final List<Code> code = response.map((e) => Code.fromJson(e)).toList();
    _getController.changeCodeModel(code);
    return true;
    }

  //get part model
  Future<bool> getPart(context) async {
    final response = await supabase.from('part').select('*');
    final List<Part> part = response.map((e) => Part.fromJson(e)).toList();
    _getController.changePartModel(part);
    return true;
  }

  //get products model
  Future<bool> getProducts(context) async {
    final response = await supabase.from('products').select('*');
    final List<Part> part = response.map((e) => Part.fromJson(e)).toList();
    _getController.changePartModel(part);
    return true;
  }
}