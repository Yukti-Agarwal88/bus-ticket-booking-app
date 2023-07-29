import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tickets_app/screens/seat_area.dart'; // Replace with your actual import path
// Replace with the actual import path for SeatReservationScreen

void main() {
  group('SeatReservationScreen Tests', () {
    testWidgets('Initial state - No seats selected',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SeatReservationScreen(
            bookedSeats:
                '4'), // Replace '4' with the desired bookedSeats value for this test
      ));

      // Ensure no seats are initially selected
      expect(find.text('Selected Seats: 0/4'), findsOneWidget);
    });

    testWidgets('Selecting seats', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SeatReservationScreen(
            bookedSeats:
                '6'), // Replace '6' with the desired bookedSeats value for this test
      ));

      // Tap on seats to select them
      await tester.tap(find.text('1'));
      await tester.tap(find.text('3'));
      await tester.tap(find.text('5'));
      await tester.pump();

      // Ensure selected seats count is updated
      expect(find.text('Selected Seats: 3/6'), findsOneWidget);
    });

    testWidgets('Deselecting seats', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SeatReservationScreen(
            bookedSeats:
                '3'), // Replace '3' with the desired bookedSeats value for this test
      ));

      // Tap on seats to select them
      await tester.tap(find.text('1'));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('3'));
      await tester.pump();

      // Tap on seats again to deselect them
      await tester.tap(find.text('1'));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('3'));
      await tester.pump();

      // Ensure selected seats count is updated
      expect(find.text('Selected Seats: 0/3'), findsOneWidget);
    });

    testWidgets('Entering correct number of seats and confirming booking',
        (WidgetTester tester) async {
      // Capture the console output using 'expectLater' and 'prints'
      await expectLater(
        () async {
          await tester.pumpWidget(MaterialApp(
            home: SeatReservationScreen(
                bookedSeats:
                    '5'), // Replace '5' with the desired bookedSeats value for this test
          ));

          // Tap on seats to select them
          await tester.tap(find.text('1'));
          await tester.tap(find.text('2'));
          await tester.tap(find.text('3'));
          await tester.tap(find.text('4'));
          await tester.tap(find.text('5'));
          await tester.pump();

          // Tap on 'Confirm your Seats' button
          await tester.tap(find.text('Confirm your Seats'));
          await tester.pumpAndSettle();
        },
        prints(contains('Seats booked successfully!')),
      );
    });
  });
}
