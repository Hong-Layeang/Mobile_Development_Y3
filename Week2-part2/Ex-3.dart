
class CustomDuration {
	final int _milliseconds;

	// Private constructor ensure non-negative milliseconds
	CustomDuration._(this._milliseconds) {
		if (_milliseconds < 0) {
			throw ArgumentError.value(_milliseconds, 'milliseconds', 'Duration must be >= 0');
		}
	}

	// Named constructors
	factory CustomDuration.fromHours(int hours) => CustomDuration._(hours * 3600000);
	factory CustomDuration.fromMinutes(int minutes) => CustomDuration._(minutes * 60000);
	factory CustomDuration.fromSeconds(int seconds) => CustomDuration._(seconds * 1000);

	// Accessors
	int get inMilliseconds => _milliseconds;
	int get inSeconds => _milliseconds ~/ 1000;
	int get inMinutes => _milliseconds ~/ 60000;
	int get inHours => _milliseconds ~/ 3600000;

	@override
	String toString() => '${_milliseconds} ms';

	// Overloaded comparison operator
	bool operator >(CustomDuration other) => _milliseconds > other._milliseconds;
	bool operator <(CustomDuration other) => _milliseconds < other._milliseconds;

	// Addition returns a new CustomDuration
	CustomDuration operator +(CustomDuration other) => CustomDuration._(_milliseconds + other._milliseconds);

	// Subtraction returns a new CustomDuration if result >= 0, otherwise throws
	CustomDuration operator -(CustomDuration other) {
		final diff = _milliseconds - other._milliseconds;
		if (diff < 0) {
			throw ArgumentError('Resulting duration would be negative ($diff ms).');
		}
		return CustomDuration._(diff);
	}

	@override
	bool operator ==(Object other) =>
			identical(this, other) ||
			other is CustomDuration && runtimeType == other.runtimeType && _milliseconds == other._milliseconds;

	@override
	int get hashCode => _milliseconds.hashCode;
}

void main() {
	final d1 = CustomDuration.fromHours(1);
	final d2 = CustomDuration.fromMinutes(30);

	print('d1: $d1');
	print('d2: $d2');
	print('d1 > d2: ${d1 > d2}');

	final sum = d1 + d2;
	print('d1 + d2 = $sum (${sum.inHours} hours, ${sum.inMinutes} minutes, ${sum.inSeconds} seconds)');

	final diff = d1 - d2;
	print('d1 - d2 = $diff');

	// demonstrate subtraction error handling
	try {
		final bad = d2 - d1;
		print(bad); // won't reach
	} catch (e) {
		print('Expected error when subtracting larger from smaller: $e');
	}
}
