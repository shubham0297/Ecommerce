import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ImageUploadService {

  
  constructor(private http : HttpClient) { }

  postImage(body: any){
    const httpOptions = {
      headers: new HttpHeaders({
          'Content-Type': 'multipart/form-data',
      })
    };
    
    console.log(body)
    return this.http.post("http://localhost:5000/addCategory",body).pipe(
          (res:any)=> {return res}
    )
  }

  postProductImage(body:any ){
    return this.http.post("http://localhost:5000/addProduct",body).pipe(
      (res:any)=> {return res}
    )
}

}
