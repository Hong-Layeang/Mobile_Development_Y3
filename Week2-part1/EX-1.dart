enum Skill { FLUTTER, DART, OTHER }

class Address {
  final String street;
  final String city;
  final String zipCode;

  const Address({
    required this.street,
    required this.city,
    required this.zipCode,
  });

  @override
  String toString() => '$street, $city $zipCode';
}

class Employee {
  final String _name;
  final double _baseSalary;
  final List<Skill> _skills;
  final Address _address;
  final int _yearsOfExperience;

  Employee({
    required String name,
    double baseSalary = 40000,
    List<Skill>? skills,
    required Address address,
    int yearsOfExperience = 0,
  })  : _name = name,
        _baseSalary = baseSalary,
        _skills = List.unmodifiable(skills ?? const []),
        _address = address,
        _yearsOfExperience = yearsOfExperience;

  // Named constructor
  Employee.mobileDeveloper({
    required String name,
    double baseSalary = 40000,
    required Address address,
    int yearsOfExperience = 0,
  }) : _name = name,
       _baseSalary = baseSalary,
       _skills = const [Skill.FLUTTER, Skill.DART],
       _address = address,
       _yearsOfExperience = yearsOfExperience;

  // Getters methods
  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => _skills;
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  double computeSalary() {
    var salary = _baseSalary + _yearsOfExperience * 2000;
    for (var s in _skills) {
      switch (s) {
        case Skill.FLUTTER:
          salary += 5000;
          break;
        case Skill.DART:
          salary += 3000;
          break;
        case Skill.OTHER:
          salary += 1000;
          break;
      }
    }
    return salary;
  }

  void printDetails() {
    print('Employee: $_name');
    print('Address: $_address');
    print('Base salary: \$${_baseSalary.toStringAsFixed(2)}');
    print('Years experience: $_yearsOfExperience');
    print('Skills: ${_skills.map((s) => s.toString().split('.').last).join(', ')}');
    print('Computed salary: \$${computeSalary().toStringAsFixed(2)}');
  }
}

void main() {
  // mobile developer
  const address1 = Address(street: '123 Main St', city: 'Phnom Penh', zipCode: '12000');
  var mobileDev = Employee.mobileDeveloper(
    name: 'Sokea',
    address: address1,
    yearsOfExperience: 3,
  );
  mobileDev.printDetails();

  print('---');

  // custom employee with OTHER skill
  const address2 = Address(street: '500 River Rd', city: 'Siem Reap', zipCode: '17000');
  var emp2 = Employee(
    name: 'Ronan',
    baseSalary: 45000,
    skills: [Skill.OTHER],
    address: address2,
    yearsOfExperience: 2,
  );
  emp2.printDetails();

  assert(mobileDev.computeSalary() == (40000 + 3 * 2000 + 5000 + 3000));
}
