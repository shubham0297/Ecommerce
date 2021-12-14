import { Component, OnInit, ViewChild } from '@angular/core';
import { Observable } from 'rxjs';
import { LoginInterface } from 'src/app/models/login-interface';
import { CartService } from 'src/app/service/cart.service';
import { LoginService } from 'src/app/service/login.service';
import { AdminComponent } from '../admin/admin.component';
import { LoginComponent } from '../login/login.component';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  public totalItem : number = 0;
  public searchTerm !: string;
  public user :any
  showDropDown:boolean = false;
  
  constructor(private cartService : CartService, private loginService: LoginService) {
    this.user = this.loginService.userValue;
    console.log(this.user)
    console.log(this.loginService.userValue)
   }

  // LoginStatus$ : Observable<number> | undefined;
  // userData$: Observable<LoginInterface> | undefined 

  ngOnInit(): void {

    this.cartService.getProducts()
    .subscribe(res=>{
      this.totalItem = res.length;
    })

    // this.LoginStatus$?.subscribe(
    //   res => this.isLogged
    // );
    // this.userData$ = this.loginService.userDetails;
    // console.log("In header", this.LoginStatus$)
  }

  search(event:any){
    this.searchTerm = (event.target as HTMLInputElement).value;
    console.log(this.searchTerm);
    this.cartService.search.next(this.searchTerm);
  }

  logout(){
    this.loginService.logout()
  }
}
