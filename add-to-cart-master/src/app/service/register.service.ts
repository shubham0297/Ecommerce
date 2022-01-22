import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

const url = "http://localhost:5000/register"

@Injectable({
  providedIn: 'root'
})
export class RegisterService {

  constructor(private http : HttpClient) { }
  
  register(body:any){
    // console.log("In register service")
    console.log(body)
    return this.http.post(url,body).subscribe(
          (res:any)=> {return res}
      )
  }
}
