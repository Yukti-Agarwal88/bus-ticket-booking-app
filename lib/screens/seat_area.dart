import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:tickets_app/utils/consts.dart';

class SeatReservationScreen extends StatefulWidget {
  String bookedSeats;
  SeatReservationScreen({super.key, required this.bookedSeats});

  @override
  _SeatReservationScreenState createState() => _SeatReservationScreenState();
}

class _SeatReservationScreenState extends State<SeatReservationScreen> {
  List<bool> seats = List.generate(36, (_) => false);
  int selectedSeatsCount = 0;
  int totalSeatsToBook = 0;
  TextEditingController textEditingController = TextEditingController();

  void _updateSelectedSeatsCount() {
    int count = 0;
    for (bool isSelected in seats) {
      if (isSelected) count++;
    }
    setState(() {
      selectedSeatsCount = count;
    });
  }

  void _validateBooking() {
    int enteredSeats = int.tryParse(widget.bookedSeats) ?? 0;
    if (enteredSeats != selectedSeatsCount) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'The number of selected seats and the entered value do not match.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Perform seat booking logic here.
      // For simplicity, we're not implementing the actual booking in this example.
      print('Seats booked successfully!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text('Seat Reservation'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Container(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
            child: Row(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Number of Seats to be Booked-',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Selected Seats-',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.bookedSeats,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$selectedSeatsCount/${widget.bookedSeats}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        // padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: DelayedDisplay(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: const EdgeInsets.fromLTRB(64, 16, 64, 16),
                  child: Stack(children: [
                    Column(
                      children: [
                        const Spacer(),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: Border.all(
                                color: AppColor.vehicleBorder, width: 2),
                          ),
                        ),
                        const Spacer(flex: 2),
                        // 2 below handles

                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: Border.all(
                                color: AppColor.vehicleBorder, width: 2),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        border:
                            Border.all(color: AppColor.vehicleBorder, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemCount: seats.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  seats[index] = !seats[index];
                                  _updateSelectedSeatsCount();
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(12),
                                child: Image.asset(
                                  seats[index]
                                      ? 'assets/images/seats/seat_3.jpg'
                                      : 'assets/images/seats/seat_1.jpg',
                                  width: 28,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/seats/seat_1.jpg',
                    width: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Available',
                    style: TextStyle(
                      color: AppColor.lightGrey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Image.asset(
                    'assets/images/seats/seat_3.jpg',
                    width: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Selected',
                    style: TextStyle(
                      color: AppColor.lightGrey,
                    ),
                  ),
                ],
              ),
            ),
            DelayedDisplay(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () => _validateBooking(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return AppColor.lightGrey;
                        }
                        return Colors.blue[800]!;
                      },
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: Text(
                      'Proceed to payment',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
