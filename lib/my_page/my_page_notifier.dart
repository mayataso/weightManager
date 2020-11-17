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
  void popUpForm() {
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
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '後悔先に立たず',
                    labelText: '懺悔の一言'),
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
                _register();
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

  void _register() {
    final formRecord = {
      'weight': state.weight,
      'comment': state.comment,
      'day': DateTime.now().toString(),
    };
    print(formRecord);
    final newRecord = List<Map<String, String>>.from(state.record);
    newRecord.add(formRecord);
    state = state.copyWith(record: newRecord);
    print(state.record);
    Navigator.pop(context);
  }
}
