import 'package:flutter/material.dart';

void showmenu(
    DateTime day, Map<DateTime, List> _allEvents, BuildContext context) {
  //날짜 클릭하면 뜨는 메뉴
  bool haveEvent = _allEvents.containsKey(DateTime.parse(day
      .toString()
      .replaceAll("12", "00")
      .replaceAll("Z", ""))); //왜인지는 모르겠는데 파라미터형태가 ****-**-** 12:00:00.000Z으로옴
  //문자열로 바꾸기 > 12를 00으로, Z없애기 > 다시 datetime형태로 바꾸기 > _allevent에 그날짜의 이벤트가 있는지 확인 ? true : false
  int eventCount;
  if (haveEvent) {
    //이벤트가 있으면
    eventCount = _allEvents[DateTime.parse(
            day.toString().replaceAll("12", "00").replaceAll("Z", ""))]
        .length; //그 길이만큼 eventCount 설정
  } else {
    eventCount = 0; //없으면 0
  } //null값은 length를 못써서 따로 설정해줘야함

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          //테두리 박스
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            color: Color(0xff232f34),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 36,
              ),
              SizedBox(
                  height: (45 * 6).toDouble(), //안쪽 컨테이너 높이
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        color: Color(0xff344955),
                      ),
                      child: Stack(
                        alignment: Alignment(0, 0),
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Positioned(
                            top: -36,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  border: Border.all(
                                      color: Color(0xff232f34), width: 10)),
                              child: Center(
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/HA/yang2.jpg", //중간 아이콘 사진
                                    fit: BoxFit.cover,
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: eventCount, //일정의 갯수
                                itemBuilder: (BuildContext context, int i) {
                                  //_allEvents에 일정PK도 넣어놔서 홀수번째 index에는 listtile을 만들면안됨
                                  if (i % 2 != 0) {
                                    return SizedBox();
                                  } else {
                                    // 0,짝수번째 index만 listTile만들기
                                    print(i);
                                    return ListTile(
                                      leading: Icon(Icons.people),
                                      title: Text(
                                          //이벤트 짝수 인덱스만 출력
                                          "${_allEvents[DateTime.parse(day.toString().replaceAll("12", "00").replaceAll("Z", ""))][i]}"),
                                      trailing: Icon(Icons.ac_unit),
                                      onTap: () {},
                                    );
                                  }
                                }),
                          )
                        ],
                      ))),
              Container(
                //일정알림창에 밑에 있는 의미없는박스 , 지워봤는데 안이뻐서 다시넣음
                height: 56,
                color: Color(0xff4a6572),
              )
            ],
          ),
        );
      });
}
