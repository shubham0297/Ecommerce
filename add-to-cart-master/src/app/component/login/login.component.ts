import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router'; 
import { LoginService } from 'src/app/service/login.service';
import { LoginInterface } from 'src/app/models/login-interface';
@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  model: any = {}
  fromRegister:any =''
  routeState: any;
  loginSuccess: Boolean = false
  @Output() notifyParent = new EventEmitter<LoginInterface> ()
  
  constructor(private router: Router, private loginService: LoginService) {
    if (this.router.getCurrentNavigation()?.extras.state) {
      console.log("In constructor")
      console.log(this.router.getCurrentNavigation())
      this.routeState = this.router.getCurrentNavigation()?.extras.state;
      if (this.routeState) {
        this.fromRegister = this.routeState.fromRegister ;
      }
    }
    console.log(this.fromRegister)
  }

  ngOnInit() {
  }
  resp : any 
  loginData: LoginInterface | undefined
  login(data:any): void {
    const formData = new FormData();
    formData.append("username", this.model.username)
    formData.append("password",this.model.password)
    console.log(formData)

    this.loginService.login(formData).subscribe(
      res=> {
        console.log(res) ;
        this.resp = res
        if(this.resp.result == 1){
          console.log("Yaaaaaay")
          console.log("True")
          this.notifyParent.emit(this.resp.data[0])
          this.router.navigate(['/admin'], { state:{fromRegister:"true", data: this.resp.data[0]}})
        }
      }
    )
    
    // console.log(this.allow)
    
   

  }
  isLogiedIn(){
    console.log("Hioioioioio")
    return this.resp.result;
  }

}