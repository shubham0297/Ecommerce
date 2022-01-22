import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { ApiService } from 'src/app/service/api.service';
import { ImageUploadService } from 'src/app/service/image-upload.service';

@Component({
  selector: 'app-add-products',
  templateUrl: './add-products.component.html',
  styleUrls: ['./add-products.component.scss']
})
export class AddProductsComponent implements OnInit {

  categoryList:any
  routeState:any
  productList:any
  addProductsForm!: FormGroup;
  selectedFile: File | undefined
  constructor(private imageService: ImageUploadService ,private formBuilder: FormBuilder, private router: Router, private api: ApiService) { 
    
    this.api.getCategories().subscribe(res=>
      {
        this.categoryList = res
        console.log(this.categoryList)
      }
    )


    if (this.router.getCurrentNavigation()?.extras.state) {
      console.log("In constructor")
      console.log(this.router.getCurrentNavigation())
      this.routeState = this.router.getCurrentNavigation()?.extras.state;
      if (this.routeState) {
        console.log(this.productList = this.routeState.data) ;
      }
   }
  }

  get f() { return this.addProductsForm.controls; }

  ngOnInit(): void {
    this.addProductsForm = this.formBuilder.group({
      name: ['', [Validators.required,Validators.minLength,Validators.pattern(/^(\s+\S+\s*)*(?!\s).*$/)]],
      category: ['', [Validators.required]],
      code: ['', [Validators.required,Validators.minLength,Validators.pattern(/^(\s+\S+\s*)*(?!\s).*$/)]],
      description: ['', [Validators.required]] ,
      price: ['', [Validators.required]],
    });
  }

  imageSelected(event:any){
    console.log(event)
    this.selectedFile = event.target.files[0]
  }
  
  onSubmit(event:any){
    if (this.addProductsForm.invalid) {
      // console.log("Invalid Form")
        return;
    }
    else
    {
      const productData = this.addProductsForm.value
      const formData = new FormData()
      formData.append("name",this.addProductsForm.value.name )
      formData.append("category",this.addProductsForm.value.category)
      formData.append("code",this.addProductsForm.value.code)
      formData.append("description",this.addProductsForm.value.description)
      formData.append("price",this.addProductsForm.value.price)
      formData.append("image", (this.selectedFile || '{}'),  this.selectedFile?.name )
      this.imageService.postProductImage(formData).subscribe( res=>{
        console.log(res)
        this.router.navigate(['']);
      })
    }
  }
}
