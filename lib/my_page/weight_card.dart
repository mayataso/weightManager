import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeightCard extends StatelessWidget {
  const WeightCard(this.notifier, this.records, this.index);

  final notifier;
  final records;
  final index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.cyan[300],
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(10, 10),
          ),
        ],
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            width: 120,
            child: Text(
              '${records[index]['weight']}Kg',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 24,
                        child: Icon(Icons.calendar_today),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        records[index]['day'],
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Icon(Icons.comment),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      records[index]['comment'],
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 40,
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    notifier.popUpForm(index, records[index]['weight'], records[index]['comment']);
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // ガワだけ作成
                    notifier.deleteRecord(index);
                  },
                ),
              ),
            ],
          )
          )
        ],
      ),
    );
  }
}
