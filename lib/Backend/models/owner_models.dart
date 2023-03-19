class OwnerSignUpModel {
  String name, email, pswd, phone, deviceid;
  OwnerSignUpModel(this.name, this.email, this.phone, this.pswd, this.deviceid);
}

class OwnerLoginModel {
  String email, pswd;
  OwnerLoginModel(this.email, this.pswd);
}

class StoreModel {
  String name,
      location,
      description,
      type,
      img,
      start,
      end,
      employees,
      longitude,
      latitude,
      pincode,
      gender,
      working;
  StoreModel(
      this.name,
      this.location,
      this.description,
      this.type,
      this.img,
      this.start,
      this.end,
      this.employees,
      this.longitude,
      this.latitude,
      this.pincode,
      this.gender,
      this.working);
}

class Store {
  String _id,
      name,
      location,
      id,
      description,
      type,
      img,
      start,
      end,
      employees,
      gender,
      working;
  Store(this._id, this.name, this.location, this.id, this.description,
      this.type, this.img, this.start, this.end, this.employees, this.gender,this.working);
}

class ServiceModel {
  String name, description, price, ogprice, img, ownerid, storeid, duration;

  ServiceModel(this.name, this.description, this.price, this.ogprice, this.img,
      this.ownerid, this.storeid, this.duration);
}

class GetServiceModel {
  String _id,
      name,
      description,
      price,
      ogprice,
      img,
      ownerid,
      storeid,
      duration,
      start,
      end,
      storename,
      id;
  GetServiceModel(
      this._id,
      this.name,
      this.description,
      this.price,
      this.ogprice,
      this.img,
      this.ownerid,
      this.storeid,
      this.duration,
      this.start,
      this.end,
      this.storename,
      this.id);
}

class idModel {
  String id;
  idModel(this.id);
}

class GetOrderModel {
  String _id,
      start,
      end,
      storeid,
      serviceid,
      userid,
      price,
      date,
      servicename,
      storename,
      orderid,
      status;
  GetOrderModel(
    this._id,
    this.start,
    this.end,
    this.storeid,
    this.serviceid,
    this.userid,
    this.price,
    this.date,
    this.servicename,
    this.storename,
    this.orderid,
    this.status,
  );
}
