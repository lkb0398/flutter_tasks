import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isStar = false;
  bool isDetail = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/todo.webp"),
                SizedBox(height: 10),
                Text(
                  "아직 할 일이 없습니다.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  """할 일을 추가하고 ${widget.title}에서
                  할 일을 추척하세요.""",
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      maxLines: 1,
                      style: TextStyle(fontSize: 16),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "새 할 일",
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                    Visibility(
                      visible: !isDetail,
                      child: TextField(
                        maxLines: 1,
                        style: TextStyle(fontSize: 16),
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "세부정보 추가",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Visibility(
                          visible: isDetail,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isDetail = false;
                              });
                            },
                            child: Icon(Icons.short_text_rounded, size: 24),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isStar = !isStar;
                            });
                          },
                          child: Icon(
                            Icons.star_border,
                            size: 24,
                            color: isStar ? Colors.blue : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.red,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
