import 'package:flutter/material.dart';


class PodCast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Directionality(textDirection: TextDirection.rtl, child:Scaffold(
      appBar: AppBar(
        title: Text("ما هو البودكاست"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        children:[ Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("البودكاست – Podcast عبارة عن إذاعه صوتية او محتوي صوتي متوفر علي الإنترنت، ويختلف عن الراديو في أنه يمكنك سماعه في أي وقت وليس عند البث المباشر فقط! ويمكن للبودكاست أن يكون في صيغة صوتية او فيديو ايضا. يمكنك الإستماع إليه بينما تقود السيارة أو تتنقل في المواصلات او حتي اثناء النشاطات المختلفة مثل العمل أو ممارسة الرياضة.هذا المحتوى الصوتي يتوفر في صورة قنوات وكل قناة تقوم بنشر حلقات متتالية علي فترات معينة، ويمكنك الإشتراك في هذه القنوات المختلفة لمتابعة كل حلقة جديدة ومعرفة ميعاد توفرها. ويقدم هذه الحلقات شخص او شخصين، أو يقومون بدعوة ضيف في كل حلقة والنقاش ايضا في موضوع معين ومشاركة أفكارهم البعض، وهذه المواضيع المختلفة قد تكون أي شئ بداية بريادة الأعمال، التسويق، العلوم وصولا للسفر والكوميديا وتستمر القائمة.",textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20),),
          ),

        ),
    ]
      ),







)
    );
  }
}


