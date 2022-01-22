import { Component, OnInit } from '@angular/core';
import { ApiService } from 'src/app/service/api.service';
import { LoginService } from 'src/app/service/login.service';

@Component({
  selector: 'app-order-history',
  templateUrl: './order-history.component.html',
  styleUrls: ['./order-history.component.scss']
})
export class OrderHistoryComponent implements OnInit {

  public user :any
  orderHistory:any;
  allOrders:any
  toggleOn:boolean = true
  constructor(private loginService: LoginService, private api:ApiService) {
      this.user = this.loginService.userValue;
   }

  ngOnInit(): void {
    this.api.getOrderHistory()
    .subscribe(res=>{
      this.allOrders = res;
      this.orderHistory = res; 
      this.toggleOff()   
      console.log(this.orderHistory)
    });
  }

  // this.productList.forEach((a:any) => {
      //   if(a.category ==="women's clothing" || a.category ==="men's clothing"){
      //     a.category ="fashion"
      //   }
      //   Object.assign(a,{quantity:1,total:a.price});
      // });

    toggleOff(){
      this.toggleOn = false
        
        this.orderHistory = this.allOrders.filter( (orders:any)=>{
          // console.log(orders.customer_id + " ---- "+ this.user.data.customer_id)
            return orders.customer_id === this.user.data.customer_id;
        }
      )
    }

    toggleOnButton(){
      this.toggleOn = true
      this.orderHistory = this.allOrders;
    }

    

}
