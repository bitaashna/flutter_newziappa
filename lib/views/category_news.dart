import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_newziappa/helper/news.dart';
import 'package:flutter_newziappa/models/article_model.dart';
import 'package:flutter_newziappa/views/home.dart';
class CategoryNews extends StatefulWidget {

  final String category;
  CategoryNews ({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {



  List<ArticleModel>articles=new List<ArticleModel>();
  bool _loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNewsClass newsClass=CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles=newsClass.news;
    setState(() {
      _loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flutter"),
            Text("News",style: TextStyle(
                color: Colors.blue
            ),)
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding:EdgeInsets.symmetric(horizontal: 16),
                child:Icon(Icons.save)),
          )

        ],
        centerTitle:true,
        elevation: 0.0,
      ),
      body:_loading ?Center(
        child: Container(
          child:CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                ///Blogs
                Container(
                  padding: EdgeInsets.only(top:16),
                  child:ListView.builder(
                      itemCount: articles.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context,index){
                        return BlogTile(
                          imageUrl:articles[index].urlToImage,
                          title:articles[index].title,
                          desc: articles[index].description,
                          url: articles[index].url,

                        );

                      }),
                )
              ],
            ),
          ),
      ),
      );

  }
}
