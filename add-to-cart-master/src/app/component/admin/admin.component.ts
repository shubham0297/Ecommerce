import { Component, OnInit, Output } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.scss']
})
export class AdminComponent implements OnInit {

  routeState: any;
  data:any 
  constructor(private router: Router) {
    if (this.router.getCurrentNavigation()?.extras.state) {
      console.log("In constructor")
      console.log(this.router.getCurrentNavigation())
      this.routeState = this.router.getCurrentNavigation()?.extras.state;
      if (this.routeState) {
        console.log(this.data = this.routeState.data) ;
      }
   }
  }

  ngOnInit(): void {
  }

}
