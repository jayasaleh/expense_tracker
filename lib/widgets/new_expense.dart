import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //ketika pake Text editing controller, kita harus hapus controllernya di dispose method kalau tidak akan ada memory leak(memakai memory terus menerus)
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    /**showDatePicker mengembalikan data type Future<DateTime> 
    Future adalah tipe data di Dart yang merepresentasikan nilai yang belum ada sekarang, tapi akan tersedia di masa depan (future).
    Bisa sukses → menghasilkan nilai.
    Bisa gagal → menghasilkan error.
    Karena showDatePicker itu operasi yang memakan waktu (user harus pilih tanggal dulu), jadi dia ngembaliin Future.
    */
    final pickDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    //line dibawah ini bakal dieksekusi setelah user milih tanggal
    setState(() {
      _selectedDate = pickDate;
    });
    print(pickDate);
  }

  @override
  void dispose() {
    //memberi tahu flutter untuk menghapus controller ini dari memory
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseDate() {
    final enteredAmount = double.tryParse(
      _amountController.text,
    ); //kalau gagal parse, dia bakal jadi null
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: Text(
            'Please make sure a valid title, amount, date and category was entered',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
      return;
    }
    //widget ini untuk menambahkan data
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    //untuk menutup modal ketika menambahkan data
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 30,
            decoration: InputDecoration(label: Text('Title')),
          ),

          SizedBox(height: 10),

          Row(
            children: [
              //tidak bisa menaruh Textfield didalam row tanpa Expanded
              // karna row itu ukurannya sesuai dengan isinya, jadi kalau textfield tidak di expand, dia akan mengecil sesuai dengan isinya
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  maxLength: 10,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Amount'),
                  ),
                ),
              ),

              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //memaksa dart untuk menganggap _selectedDate itu pasti ada isinya
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    //icon button bisa dipakai untuk button yang hanya berisi icon
                    //punya onPressed property yang dipanggil ketika button ditekan
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name.toUpperCase()),
                      ),
                    )
                    .toList(),

                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); //tutup modal
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseDate();
                },
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
