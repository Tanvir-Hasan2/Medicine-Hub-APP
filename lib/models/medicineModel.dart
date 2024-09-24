
const String tableMediHub = 'tbl_medicinehub';
const String tblMHubColId = 'id';
const String tblMHubColDId = 'did';
const String tblMHubColBrand = 'brand';
const String tblMHubColDosageFormId = 'dosageFormId';
const String tblMHubColDosageFromName = 'dosageFormName';
const String tblMHubColGenericId = 'genericId';
const String tblMHubColGenericName = 'genericName';
const String tblMHubColStrength = 'strength';
const String tblMHubColManufacturedById = 'manufacturedById';
const String tblMHubColManufatureByName = 'manufacturedByName';
const String tblMHubColUnitPrice = 'unitPrice';
const String tblMHubColPackSize = 'packSize';
const String tblMHubColStripPrice = 'stripPrice';
const String tblMHubColIsOtherForm = 'isOtherForm';
const String tblMHubColOtherFormBrandId = 'otherFormBrandId';
const String tblMHubColMedicineType = 'medicineType';
const String tblMHubColRemarks = 'remarks';
const String tblMHubColCreatedOn = 'createdOn';
const String tblMHubColUpdatedOn = 'updatedOn';
const String tblMHubColIsActive = 'isActive';




class MedicineModel {
  int? id;
  String? brand;
  int? dosageFormId;
  String? dosageFormName;
  int? genericId;
  String? genericName;
  String? strength;
  int? manufacturedById;
  String? manufacturedByName;
  num? unitPrice;
  String? packSize;
  num? stripPrice;
  bool? isOtherForm;
  int? otherFormBrandId;
  String? medicineType;
  String? remarks;
  String? createdOn;
  String? updatedOn;
  bool? isActive;
  MedicineModel({
    this.id,
    this.brand,
    this.dosageFormId,
    this.dosageFormName,
    this.genericId,
    this.genericName,
    this.strength,
    this.manufacturedById,
    this.manufacturedByName,
    this.unitPrice,
    this.packSize,
    this.stripPrice,
    this.isOtherForm,
    this.otherFormBrandId,
    this.medicineType,
    this.remarks,
    this.createdOn,
    this.updatedOn,
    this.isActive,
  });

  MedicineModel.fromJson(dynamic json) {
    id = json['id'];
    brand = json['brand'];
    dosageFormId = json['dosageFormId'];
    dosageFormName = json['dosageFormName'];
    genericId = json['genericId'];
    genericName = json['genericName'];
    strength = json['strength'];
    manufacturedById = json['manufacturedById'];
    manufacturedByName = json['manufacturedByName'];
    unitPrice = json['unitPrice'];
    packSize = json['packSize'];
    stripPrice = json['stripPrice'];
    isOtherForm = json['isOtherForm'];
    otherFormBrandId = json['otherFormBrandId'];
    medicineType = json['medicineType'];
    remarks = json['remarks'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    isActive = json['isActive'];
  }
  MedicineModel copyWith({
    int? id,
    String? brand,
    int? dosageFormId,
    String? dosageFormName,
    int? genericId,
    String? genericName,
    String? strength,
    int? manufacturedById,
    String? manufacturedByName,
    num? unitPrice,
    String? packSize,
    num? stripPrice,
    bool? isOtherForm,
    int? otherFormBrandId,
    String? medicineType,
    String? remarks,
    String? createdOn,
    String? updatedOn,
    bool? isActive,
  }) =>
      MedicineModel(
        id: id ?? this.id,
        brand: brand ?? this.brand,
        dosageFormId: dosageFormId ?? this.dosageFormId,
        dosageFormName: dosageFormName ?? this.dosageFormName,
        genericId: genericId ?? this.genericId,
        genericName: genericName ?? this.genericName,
        strength: strength ?? this.strength,
        manufacturedById: manufacturedById ?? this.manufacturedById,
        manufacturedByName: manufacturedByName ?? this.manufacturedByName,
        unitPrice: unitPrice ?? this.unitPrice,
        packSize: packSize ?? this.packSize,
        stripPrice: stripPrice ?? this.stripPrice,
        isOtherForm: isOtherForm ?? this.isOtherForm,
        otherFormBrandId: otherFormBrandId ?? this.otherFormBrandId,
        medicineType: medicineType ?? this.medicineType,
        remarks: remarks ?? this.remarks,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn,
        isActive: isActive ?? this.isActive,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['brand'] = brand;
    map['dosageFormId'] = dosageFormId;
    map['dosageFormName'] = dosageFormName;
    map['genericId'] = genericId;
    map['genericName'] = genericName;
    map['strength'] = strength;
    map['manufacturedById'] = manufacturedById;
    map['manufacturedByName'] = manufacturedByName;
    map['unitPrice'] = unitPrice;
    map['packSize'] = packSize;
    map['stripPrice'] = stripPrice;
    map['isOtherForm'] = isOtherForm;
    map['otherFormBrandId'] = otherFormBrandId;
    map['medicineType'] = medicineType;
    map['remarks'] = remarks;
    map['createdOn'] = createdOn;
    map['updatedOn'] = updatedOn;
    map['isActive'] = isActive;
    return map;
  }
}
