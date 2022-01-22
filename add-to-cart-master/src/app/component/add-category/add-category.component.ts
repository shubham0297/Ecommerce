import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ImageUploadService } from 'src/app/service/image-upload.service';

@Component({
  selector: 'app-add-category',
  templateUrl: './add-category.component.html',
  styleUrls: ['./add-category.component.scss']
})
export class AddCategoryComponent implements OnInit {

  selectedFile: File | undefined
  model:any = {}
  constructor(private router: Router, private imageService: ImageUploadService) { }

  ngOnInit(): void {
  }

  imageSelected(event:any){
    console.log(event)
    this.selectedFile = event.target.files[0]
  }
  processFile(event:any){  
    const formData = new FormData();
    console.log(this.model.categoryName)
    formData.append("categoryName", this.model.categoryName)
    formData.append("image", (this.selectedFile || '{}'),  this.selectedFile?.name )
    // const body = {
    //   "categoryName": this.model.categoryName,
    //   "image": this.selectedFile
    // }
    
    console.log(formData)
      this.imageService.postImage(formData).subscribe( res=>{
        console.log(res)
        this.router.navigate(['']);
      })

    }
  
}

