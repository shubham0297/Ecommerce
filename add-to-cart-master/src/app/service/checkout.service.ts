import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { CartService } from 'src/app/service/cart.service';


const url = "http://localhost:5000/checkOut"
@Injectable({
  providedIn: 'root'
})
export class CheckoutService {

  constructor(private router: Router, private cartService:CartService , private http : HttpClient) {
    
  }
 
  checkout(body:any){
    console.log("In service")
    console.log(body)
    const op = {
      headers: { 
      "Accept": "application/json",
      // "Content-Type": "text/plain"
      }
    }
    return this.http.post(url,body, op)
  }

}
