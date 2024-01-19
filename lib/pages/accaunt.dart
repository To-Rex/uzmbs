import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uzmbs/res/colors.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Supabase.instance.client.auth.currentUser!.email.toString());
    print(Supabase.instance.client.auth.currentUser!.toString());
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          'My account',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: w * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.primaryColor,
            ),
            surfaceTintColor: AppColors.backgroundColor,
            color: AppColors.backgroundColor,
            shadowColor: AppColors.primaryColor,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    HeroIcon(
                      HeroIcons.arrowLeftOnRectangle,
                      color: AppColors.orangeColor,
                      size: w * 0.06,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Log out',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: w * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    HeroIcon(
                      HeroIcons.trash,
                      color: AppColors.orangeColor,
                      size: w * 0.06,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Delete account',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: w * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                Supabase.instance.client.auth.signOut();
                Navigator.pop(context);
              }else if(value == 2){
                Navigator.pop(context);
              }
            },
          ),
        ],
        //menu log out, delete account, settings. hero icon and text
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: AppColors.primaryColor,
            surfaceTintColor: AppColors.primaryColor,
            child: Column(
              children: [
                SizedBox(height: h * 0.02),
                //active or not active
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Container(
                      width: w * 0.15,
                      height: h * 0.03,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Active',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: w * 0.035,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: w * 0.05),
                  ],
                ),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      Supabase.instance.client.auth.currentUser!.userMetadata!['avatar_url'].toString(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    Supabase.instance.client.auth.currentUser!.userMetadata!['full_name'].toString(),
                    style: TextStyle(
                      fontSize: w * 0.05,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    Supabase.instance.client.auth.currentUser!.email.toString(),
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.03),
              ],
            ),
          ),
        ],
      ),
    );
  }
}