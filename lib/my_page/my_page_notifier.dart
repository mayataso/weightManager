import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';
import 'register_button.dart';

part 'my_page_notifier.freezed.dart';

@freezed
abstract class MyPageState with _$MyPageState {
  const factory MyPageState({
    @Default(0) int count,
    String weight,
    String comment,
    @Default([]) List<Map<String, String>> record,
  }) = _MyPageState;
}

class MyPageNotifier extends StateNotifier<MyPageState> with LocatorMixin {
  MyPageNotifier({
    @required this.context,
  }) : super(const MyPageState());

  final BuildContext context;

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  void initState() {
    print('init');
  }

  void pushButton() {
    print('notifier!!');
    state = state.copyWith(count: state.count + 1);
    print(state.count);
  }

  // ポップアップ処理
  // 新規作成時はindex = -1, 編集時は編集する要素のindexが引数となる
  void popUpForm([int index = -1, String weight = "", String comment = ""]) {
    print('${state.weight}, ${state.comment}');
    // 初期値代入
    state = state.copyWith(weight: weight);
    state = state.copyWith(comment: comment);

    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('今日の体重を入力しよう'),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 24,
          ),
          children: [
            Row(
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.only(left: 4),
                  child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '嘘つくなよ',
                        labelText: '今日の体重',
                      ),
                      // 編集モード時、初期値を表示
                      initialValue: state.weight,
                      onChanged: (value) {
                        //ここ
                        _saveWeight(value);
                      },
                      keyboardType: TextInputType.number),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Kg'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              padding: EdgeInsets.only(left: 4),
              child: TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: '後悔先に立たず', labelText: '懺悔の一言'),
                // 編集モード時、初期値を表示
                      initialValue: state.comment,
                onChanged: (value) {
                  _saveComment(value);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: RegisterButton(),
              onTap: () {
                _register(index);
              },
            )
          ],
        );
      },
    );
  }

  void _saveWeight(String value) {
    print(value);
    state = state.copyWith(weight: value);
  }

  void _saveComment(String value) {
    print(value);
    state = state.copyWith(comment: value);
  }

  void _register(int index) {
    final dateTime = DateTime.now();
    final day = '${dateTime.year}年${dateTime.month}月${dateTime.day}日';
    final formRecord = {
      'weight': state.weight,
      'comment': state.comment,
      'day': day,
    };

    print(formRecord);
    final newRecord = List<Map<String, String>>.from(state.record);

    // 新規作成時と編集時で操作を分岐
    if (index == -1) {
      newRecord.add(formRecord);
    } else {
      newRecord[index] = formRecord;
    }
    _update(newRecord);

    // 入力した値をリセット
    state = state.copyWith(weight: "");
    state = state.copyWith(comment: "");

    Navigator.pop(context);
  }

  void deleteRecord(int index) {
    final newRecord = List<Map<String, String>>.from(state.record);

    newRecord.removeAt(index);

    _update(newRecord);
  }

  // 変更したデータの反映
  void _update(List<Map<String, String>> record) {
    state = state.copyWith(record: record);
  }
}
