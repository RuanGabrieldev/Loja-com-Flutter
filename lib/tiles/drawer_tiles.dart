import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page);


  @override
  Widget build(BuildContext context) {
    return Material(
      
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: Container(
          height: 60,
          child: ListTile(
            title: Text(text, style:TextStyle(fontSize: 20, color: pageController.page.round() == page ? Theme.of(context).primaryColor: Colors.grey,)),
            leading: Icon(icon,size: 30, color: pageController.page.round() == page ? Theme.of(context).primaryColor: Colors.grey,),
          ),
        ),
      ),
    );
  }
}