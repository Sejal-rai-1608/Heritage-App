import 'package:flutter/material.dart';

class SelectAreaModal extends StatefulWidget {
  const SelectAreaModal({super.key});

  @override
  State<SelectAreaModal> createState() => _SelectAreaModalState();
}

class _SelectAreaModalState extends State<SelectAreaModal> {
  static const Color primaryNavy = Color(0xFF00005C);

  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  String _selectedCountry = 'India';
  String _selectedState = 'Select State';
  String _selectedDistrict = 'Select District';

  final List<String> _countries = ['India', 'USA', 'UK', 'Canada', 'Australia'];

  final List<String> _states = [
    'Select State',
    'Gujarat',
    'Maharashtra',
    'Rajasthan',
    'Madhya Pradesh',
    'Karnataka',
  ];

  final List<String> _districts = [
    'Select District',
    'Ahmedabad',
    'Surat',
    'Rajkot',
    'Vadodara',
    'Mumbai',
    'Pune',
    'Jaipur',
    'Indore',
  ];

  @override
  void dispose() {
    _pincodeController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    String result = '';
    final pin = _pincodeController.text.trim();
    final area = _areaController.text.trim();

    if (area.isNotEmpty) {
      result = area;
      if (_selectedDistrict != 'Select District') {
        result += ', $_selectedDistrict';
      }
      if (_selectedState != 'Select State') {
        result += ', $_selectedState';
      }
    } else if (pin.isNotEmpty) {
      result = 'Pin: $pin';
      if (_selectedCountry.isNotEmpty) {
        result += ' ($_selectedCountry)';
      }
    } else {
      if (_selectedDistrict != 'Select District') {
        result = _selectedDistrict;
      }
      if (_selectedState != 'Select State') {
        result = result.isEmpty ? _selectedState : '$result, $_selectedState';
      }
    }

    if (result.isEmpty) {
      result = _selectedCountry;
    }

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryNavy,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Area',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: _onConfirm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Country
              const Text(
                'Country',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCountry,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    items: _countries.map((c) {
                      return DropdownMenuItem(value: c, child: Text(c));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedCountry = val;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Pincode
              const Text(
                'Pincode',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Postal Pin Code e.g. 400091',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.orange,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Or divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Or',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 20),

              // State
              const Text(
                'State',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedState,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    items: _states.map((s) {
                      return DropdownMenuItem(value: s, child: Text(s));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedState = val;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // District
              const Text(
                'District',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedDistrict,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    items: _districts.map((d) {
                      return DropdownMenuItem(value: d, child: Text(d));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedDistrict = val;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Area
              const Text(
                'Area',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _areaController,
                decoration: InputDecoration(
                  hintText: 'Type Area e.g. Borivali',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: primaryNavy,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Select Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Select',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
