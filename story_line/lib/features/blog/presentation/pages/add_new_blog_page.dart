import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const AddNewBlogPage(),);
  const AddNewBlogPage({super.key});
  
  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))
        ],
      ),
      body: Column(
        children: [
          DottedBorder(
            child: Container(
              height: 150,
              width: double.infinity,
              child: const Column(
                children: [
                  Icon(
                    Icons.folder_open, size: 40,
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'Select your image',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}