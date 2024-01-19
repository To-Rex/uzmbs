import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:uzmbs/main.dart';
import 'package:uzmbs/models/currency_model.dart';
import 'package:uzmbs/pages/accaunt.dart';
import 'package:uzmbs/res/colors.dart';
import 'package:uzmbs/res/getController.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/company_model.dart';
import 'models/product_in_warehouse.dart';
import 'models/unito_of_measure.dart';

class SamplePage extends StatelessWidget {
  SamplePage({Key? key}) : super(key: key);

  final GetController _getController = Get.put(GetController());

  final TextEditingController codeController = TextEditingController();
  final TextEditingController additionalPayment = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void _onItemTapped(int index) {
    print(index);
    _getController.changeIndex(index);
    _getController.changeWidgetOptions();
  }

  void showSnackbar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  //show dialog
  void showAlertDialog(BuildContext context, title, message) {
    var w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: w * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: w * 0.035,
          ),
        ),
        //ok button
        actions: [
          SizedBox(
            width: w * 0.2,
            height: w * 0.08,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                'Ok',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: w * 0.035,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //addProduct bottom sheet
  addProduct(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var currencyCode = '';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      showDragHandle: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) => Container(
        height: h * 0.8,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.06,
              margin: EdgeInsets.only(top: h * 0.02, left: w * 0.05, right: w * 0.05),
              padding: EdgeInsets.only(right: w * 0.05, left: w * 0.05),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() => _getController.companyModel.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _getController.companyModel.value[_getController.selectedDropDown.value].companyName,
                        icon: HeroIcon(
                          HeroIcons.chevronDown,
                          size: w * 0.05,
                          color: AppColors.primaryColor,
                        ),
                        iconSize: w * 0.05,
                        elevation: 16,
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: w * 0.035,
                        ),
                        onChanged: (String? newValue) {
                          _getController.selectedDropDown.value = _getController.companyModel.value.indexWhere((element) => element.companyName == newValue);
                        },
                        items: _getController.companyModel.value.map<DropdownMenuItem<String>>((Company value) {
                          return DropdownMenuItem<String>(
                            value: value.companyName,
                            child: Text(value.companyName),
                          );
                        }).toList(),
                      ),
                    )
              )
            ),
            //textfild code product
            Container(
              width: w,
              height: h * 0.06,
              margin: EdgeInsets.only(top: h * 0.02, left: w * 0.05, right: w * 0.05),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextField(
                  controller: codeController,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Code',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: w * 0.05),
                  ),
                ),
              ),
            ),
            //textfild additional payment
            Container(
              width: w,
              height: h * 0.06,
              margin: EdgeInsets.only(top: h * 0.02, left: w * 0.05, right: w * 0.05),
              padding: EdgeInsets.only(right: w * 0.05),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: TextField(
                  controller: additionalPayment,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    //usd or euro or other
                    suffix: Text(
                      currencyCode,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    hintText: 'Additional payment',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: w * 0.05),
                  ),
                ),
              ),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(top: h * 0.02, left: w * 0.05, right: w * 0.05, bottom: h * 0.02),
              child: Row(
                children: [
                  Text(
                    'Products in warehouse',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: w * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //add product quantity
                  const Spacer(),
                  //add product quantity textfild and unit of measure
                  Container(
                    width: w * 0.3,
                    height: h * 0.06,
                    margin: EdgeInsets.only( left: w * 0.01),
                    padding: EdgeInsets.only(right: w * 0.05),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: w * 0.035
                        ),
                        decoration: InputDecoration(
                          hintText: 'Quantity',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: w * 0.03
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: w * 0.04)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //listview product code,name,part,priece,additional payment
            Expanded(
              child: ListView.builder(
                itemCount: _getController.productInWarehouse.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      codeController.text = _getController.productInWarehouse[index].code;
                      additionalPayment.text = _getController.productInWarehouse[index].additionalPayment.toString();
                      currencyCode = _getController.currencyModel[index].code;
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: h * 0.02, left: w * 0.05, right: w * 0.05),
                      child: Container(
                        padding: EdgeInsets.only(left: w * 0.05, right: w * 0.03),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                HeroIcon(
                                  HeroIcons.cube,
                                  size: w * 0.05,
                                  color: AppColors.primaryColor,
                                ),
                                Container(
                                  height: h * 0.06,
                                  margin: EdgeInsets.only(
                                      right: w * 0.02, left: w * 0.01),
                                  child: Center(
                                    child: Text(
                                      _getController
                                          .productInWarehouse[index].name,
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                //code
                                SizedBox(
                                  height: h * 0.06,
                                  child: Center(
                                    child: Text(
                                      _getController.productInWarehouse[index].code,
                                      style: TextStyle(
                                        color: AppColors.orangeColor,
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: w,
                              child: Text(
                                '${_getController.productInWarehouse[index].quantity} ${_getController.unitOfMeasure[index].unitCode} - ${_getController.unitOfMeasure[index].description} in warehouse',
                                maxLines: 1,
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: w * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: h * 0.06,
                                  margin: EdgeInsets.only(
                                      right: w * 0.02, left: w * 0.01),
                                  child: Center(
                                    child: Text(
                                      '${_getController.productInWarehouse[index].price} ${_getController.currencyModel[index].code}',
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                //additional payment
                                HeroIcon(
                                  HeroIcons.arrowTrendingUp,
                                  size: w * 0.05,
                                  color: AppColors.primaryColor,
                                ),
                                Container(
                                  height: h * 0.06,
                                  margin: EdgeInsets.only(
                                      right: w * 0.01, left: w * 0.01),
                                  child: Center(
                                    child: Text(
                                      _getController.productInWarehouse[index]
                                          .additionalPayment
                                          .toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.06,
                                  child: Center(
                                    child: Text(
                                      _getController.currencyModel[index].code,
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //elevatedbutton add product
            Container(
              width: w,
              height: h * 0.06,
              margin: EdgeInsets.only(top: h * 0.02, left: w * 0.05, right: w * 0.05, bottom: h * 0.04),
              child: ElevatedButton(
                onPressed: () {
                  if (codeController.text.isNotEmpty && additionalPayment.text.isNotEmpty) {
                    if (_getController.index.value == 0) {
                      supabase.from('import').insert([{
                        'product_id': _getController.productInWarehouse[_getController.selectedDropDown.value].id,
                        'import_date': DateTime.now().toString(),
                        'quantity': quantityController.text == '' ? 1 : int.parse(quantityController.text),
                        'source': 'UZMBC',
                        'receiving_company': _getController.companyModel[_getController.selectedDropDown.value].companyName,
                        'tracking_number': '123456789',
                        'additional_payment': additionalPayment.text,
                        'additional_payment_currency_id': _getController.currencyModel[_getController.selectedDropDown.value].id,
                        'company_id': _getController.companyModel[_getController.selectedDropDown.value].companyId,
                      }]).then((value) {
                        if (value == null) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          showAlertDialog(context, 'Error', 'Hamma maydonlarni to\'ldiring');
                        }
                      });
                    } else if (_getController.index.value == 1) {
                      supabase.from('export').insert([{
                        'product_id': _getController.productInWarehouse[_getController.selectedDropDown.value].id,
                        'export_date': DateTime.now().toString(),
                        'quantity': quantityController.text == '' ? 1 : int.parse(quantityController.text),
                        'destination': _getController.companyModel[_getController.selectedDropDown.value].companyName,
                        'shipping_company': 'UZMBC',
                        'tracking_number': '123456789',
                        'additional_payment': additionalPayment.text,
                        'additional_payment_currency_id': _getController.currencyModel[_getController.selectedDropDown.value].id,
                        'company_id': _getController.companyModel[_getController.selectedDropDown.value].companyId,
                      }
                      ]).then((value) {
                        if (value == null) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          showAlertDialog(context, 'Error', 'Hamma maydonlarni to\'ldiring');
                        }
                      });
                    } else {
                      //add product check
                    }
                  } else {
                    showAlertDialog(context, 'Error', 'Hamma maydonlarni to\'ldiring');
                    return;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: Obx(() => _getController.index.value == 0
                      ? Text(
                          'Add Product Import',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w * 0.035,
                          ),
                        )
                      : _getController.index.value == 1
                          ? Text(
                              'Add Product Export',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.035,
                              ),
                            )
                          : Text(
                              'Add Product Check',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.035,
                              ),
                            )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    _getController.changeWidgetOptions();
    _getController.changeIndex(0);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text(
          'UZMBC',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AccountPage()));
            },
            icon: CircleAvatar(
              radius: w * 0.04,
              backgroundImage: NetworkImage(
                Supabase.instance.client.auth.currentUser!
                    .userMetadata!['avatar_url']
                    .toString(),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() => _getController.widgetOptions.elementAt(_getController.index.value)),
      //floatingActionButton add
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        foregroundColor: AppColors.orangeColor,
        onPressed: () {
          addProduct(context);
          //showAlertDialog(context, 'Error', 'Hamma maydonlarni to\'ldiring');
        },
        backgroundColor: AppColors.primaryColor,
        child: HeroIcon(
          HeroIcons.plus,
          size: w * 0.07,
          color: AppColors.whiteColor,
        ),
      ),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: AppColors.backgroundColor,
          unselectedItemColor: AppColors.whiteColor,
          showSelectedLabels: false,
          selectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: HeroIcon(
                HeroIcons.inboxArrowDown,
                size: w * 0.07,
              ),
              label: 'Import',
              activeIcon: HeroIcon(
                HeroIcons.inboxArrowDown,
                size: w * 0.07,
                color: AppColors.primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: HeroIcon(
                HeroIcons.inboxStack,
                size: w * 0.07,
              ),
              label: 'Export',
              activeIcon: HeroIcon(
                HeroIcons.inboxStack,
                size: w * 0.07,
                color: AppColors.primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: HeroIcon(
                HeroIcons.inbox,
                size: w * 0.07,
              ),
              label: 'Check',
              //notification icon
              activeIcon: HeroIcon(
                HeroIcons.inbox,
                size: w * 0.07,
                color: AppColors.primaryColor,
              ),
            ),
          ],
          currentIndex: _getController.index.value,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
