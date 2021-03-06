import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from 'src/app/service/api.service';
import { CartService } from 'src/app/service/cart.service';
import { LoginService } from 'src/app/service/login.service';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent implements OnInit {

  public productList : any ;
  public filterCategory : any
  public categoryList: any;
  searchKey:string ="";
  public user :any
  constructor(private loginService: LoginService, private api : ApiService, private cartService : CartService) { 
    this.user = this.loginService.userValue;
  }

  ngOnInit(): void {
    this.api.getProduct()
    .subscribe(res=>{
      this.productList = res;
      this.filterCategory = res;
      this.productList.forEach((a:any) => {
        if(a.category ==="women's clothing" || a.category ==="men's clothing"){
          a.category ="fashion"
        }
        Object.assign(a,{quantity:1,total:a.price});
      });
      console.log(this.productList)
      this.api.getCategories().subscribe(res=>{
        this.categoryList = res;
      });
    });

    this.cartService.search.subscribe((val:any)=>{
      this.searchKey = val;
    })

    
  }
  addtocart(item: any){
    this.cartService.addtoCart(item);
  }
  filter(categoryName:string){
    let category = 0
    if (categoryName == ''){
        this.filterCategory = this.productList
        return
    }
      

    if(categoryName == 'electronics'){
      category = 4
    } else if(categoryName == 'fashion'){
      category = 1
    } else if(categoryName == 'jewelery'){
      category = 2
    }
    this.filterCategory = this.productList
    .filter((a:any)=>{
      if(a.category_id == category){
        return a;
      }
    })
  }

  

}
