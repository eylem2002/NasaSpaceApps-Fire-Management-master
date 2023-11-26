import 'package:flutter/material.dart';

import '../../Core/Models/option_model.dart';
import '../../Core/Route/static_routes.dart';
import '../../Utils/theme_manager.dart';

class OptionsView extends StatefulWidget {
  const OptionsView({super.key});

  @override
  State<OptionsView> createState() => _OptionsViewState();
}

class _OptionsViewState extends State<OptionsView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,

          itemBuilder: (context,index) {
            return InkWell(
              onTap: (){

                 Navigator.of(context).pushNamed(optionsList[index]!.navigationTo);


              },
              child: Column
                (
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Expanded(
                    child: CircleAvatar(
                      child: Image.asset(
                          optionsList[index]!.imagePath!
                      ),
                      maxRadius: 25,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    optionsList[index].name!,
                    style: TextStyle(
                        fontSize: 10,
                        color: ThemeManager.textColor
                    ),
                  )
                ],
              ),
            );
          }, separatorBuilder: (context,index) {
        return SizedBox(width: 20,);
      }, itemCount: optionsList.length),
    );
  }
}