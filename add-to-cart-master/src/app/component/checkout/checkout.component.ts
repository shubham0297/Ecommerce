import { Component, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ApiService } from 'src/app/service/api.service';
import { CartService } from 'src/app/service/cart.service';
import { CheckoutService } from 'src/app/service/checkout.service';
import { ImageUploadService } from 'src/app/service/image-upload.service';
import { ModalManager } from 'ngb-modal';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.scss']
})
export class CheckoutComponent implements OnInit {

  checkOutForm!: FormGroup;
  routeState:any
  order_data:any
  showModal:boolean = false;
  @ViewChild('successModal') successModal: any;
  private modalRef: any;
  
  constructor(private modalService: ModalManager, private cartService: CartService,private checkOutService: CheckoutService, private router:Router, private formBuilder: FormBuilder) { 
    if (this.router.getCurrentNavigation()?.extras.state) {
      // console.log("In constructor")
      console.log(this.router.getCurrentNavigation())
      this.routeState = this.router.getCurrentNavigation()?.extras.state;
      if (this.routeState) {
        console.log(this.routeState) ;
        this.order_data = this.routeState
      }
    }
  }

  ngOnInit(): void {
    this.checkOutForm = this.formBuilder.group({
      line1: ['', [Validators.required,Validators.minLength,Validators.pattern(/^(\s+\S+\s*)*(?!\s).*$/)]],
      line2: [null],
      city: ['', [Validators.required,Validators.minLength,Validators.pattern(/^(\s+\S+\s*)*(?!\s).*$/)]],
      state: ['', [Validators.required,Validators.maxLength]] ,
      zipcode: ['', [Validators.required,Validators.maxLength]],
      phone: ['', [Validators.required, Validators.minLength, Validators.maxLength]]
    });
  }

  
  get f() { return this.checkOutForm.controls; }

  onSubmit(){
    if (this.checkOutForm.invalid) {
      // console.log("Invalid Form")
        return;
    }
    else
    {
      
      this.order_data["customerData"] = this.checkOutForm.value
      this.checkOutService.checkout(this.order_data).subscribe(
        (res:any)=> {
          this.cartService.removeAllCart();
          this.showModal = true
          this.openModal()
          this.router.navigate(['']);

        })
      
      // this.router.navigate(['']);
    }
  }

    openModal(){
      console.log("Hiiii")
        this.modalRef = this.modalService.open(this.successModal, {
            size: "md",
            modalClass: 'mymodal',
            hideCloseButton: false,
            centered: false,
            backdrop: true,
            animation: true,
            keyboard: false,
            closeOnOutsideClick: true,
            backdropClass: "modal-backdrop"
        })
    }
    closeModal(){
        this.modalService.close(this.modalRef);
        //or this.modalRef.close();
    }

}
