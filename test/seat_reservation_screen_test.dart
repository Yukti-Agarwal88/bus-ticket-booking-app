import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tickets_app/screens/seat_reservation_screen.dart';

void main() {
  group('SeatReservationScreen widget', () {
    testWidgets('Renders the screen', (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(home: SeatReservationScreen(bookedSeats: '2')));

      //For Verify if the widgets are rendered on the screen.
      expect(find.text('Seat Reservation'), findsOneWidget);
      expect(find.text('Number of Seats to be Booked-'), findsOneWidget);
      expect(find.text('Selected Seats-'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('0/2'), findsOneWidget);
    });

    testWidgets('Test seat booking validation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SeatReservationScreen(
            bookedSeats:
                '4'), // Replace '4' with your desired number of seats to be booked for testing.
      ));

      await tester.tap(find.byType(GestureDetector).first);
      await tester.tap(find.byType(GestureDetector).at(1));
      await tester.pump();

      //For Tapping on the "Confirm your seats" button.
      await tester.tap(find.text('Confirm your seats'));
      await tester.pump();

      // Check that the validation error dialog is shown.
      expect(find.text('Error'), findsOneWidget);
      expect(
          find.text(
              'The number of selected seats and the entered value do not match.'),
          findsOneWidget);
    });

    testWidgets('Validate booking with wrong seat count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(home: SeatReservationScreen(bookedSeats: '2')));

      // Select one seat instead of two.
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      // Verify if the selected seats count is updated.
      expect(find.text('1/2'), findsOneWidget);

      // Tap on the Confirm button and expect an error dialog.
      await tester.tap(find.text('Confirm your seats'));
      await tester.pump();

      expect(find.text('Error'), findsOneWidget);
      expect(
          find.text(
              'The number of selected seats and the entered value do not match.'),
          findsOneWidget);
    });
  });
}
