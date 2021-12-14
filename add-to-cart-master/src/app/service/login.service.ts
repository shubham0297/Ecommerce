import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { BehaviorSubject, Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { LoginInterface } from '../models/login-interface';


const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type':  'application/json'
  })
};
@Injectable({
  providedIn: 'root'
})
export class LoginService {

  private userSubject: BehaviorSubject<any>;
  public user: Observable<LoginInterface>;

  constructor(private router: Router, private http : HttpClient) {
      this.userSubject = new BehaviorSubject<any>(JSON.parse(localStorage.getItem('user')|| '{}'));
      this.user = this.userSubject.asObservable();
  }

  public get userValue(): LoginInterface {
    return this.userSubject.value;
  }
  
  
  result:any 
  login(body: any){
    console.log(body)
    return this.http.post("http://localhost:5000/login",body).pipe(
      map(( (user:any) => {
        // store user details and jwt token in local storage to keep user logged in between page refreshes
          localStorage.setItem('user', JSON.stringify(user));
          this.userSubject.next(user);
          return user;
      }))
    )
  }

  logout() {
    // remove user from local storage and set current user to null
    localStorage.removeItem('user');
    this.userSubject.next(null);
    this.router.navigate(['']);
}
    
    
}


