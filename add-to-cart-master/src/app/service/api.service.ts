import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import {map} from 'rxjs/operators';
@Injectable({
  providedIn: 'root'
})
export class ApiService {

  // https://fakestoreapi.com/products

  constructor(private http : HttpClient) { }

  getProduct(){
    return this.http.get<any>("http://localhost:5000/products")
    // return this.http.get<any>(" https://fakestoreapi.com/products")
    .pipe(map((res:any)=>{
      return res;
    }))
  }

  getCategories(){
    return this.http.get<any>("http://localhost:5000/categories")
    .pipe(map((res:any)=>{
      return res;
    }))
  }

  getOrderHistory(){
    return this.http.get<any>("http://localhost:5000/orderHistory")
    .pipe(map((res:any)=>{
      return res;
    }))
  }
}
